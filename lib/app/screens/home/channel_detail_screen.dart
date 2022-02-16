import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../controller/controller.dart';
import '../../data/models/home/channel_model.dart';

class ChannelDetailScreen extends StatefulWidget {
  final Channel? channel;
  const ChannelDetailScreen({Key? key, this.channel}) : super(key: key);

  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  final ChannelController controller = ChannelController.to;
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerConfiguration betterPlayerConfiguration;

  @override
  void initState() {
    controller.getChannelData(widget.channel!.id);
    BetterPlayerControlsConfiguration controlsConfiguration =
        const BetterPlayerControlsConfiguration(
      playIcon: Icons.play_arrow,
      enableSubtitles: false,
      enableAudioTracks: false,
      enableSkips: true,
      enableFullscreen: true,
      controlBarHeight: 60,
      loadingWidget: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
    betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      controlsConfiguration: controlsConfiguration,
    );

    super.initState();
  }

  @override
  void dispose() {
    if (_betterPlayerController.isPlaying() == true) {
      _betterPlayerController.pause();
      _betterPlayerController.clearCache();
    }
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            Hero(
              tag: widget.channel!.name! + widget.channel!.lang,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.channel!.getLogoURL(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Hero(
              tag: widget.channel!.name! +
                  widget.channel!.lang +
                  widget.channel!.template,
              transitionOnUserGestures: true,
              child: Material(
                type: MaterialType.transparency, // likely needed
                child: Text(
                  widget.channel!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            width: 40,
            margin: const EdgeInsets.only(right: 20.0, top: 8, bottom: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: IconButton(
              color: kPrimaryColor,
              onPressed: () async {
                controller.channel.value = null;
                Get.back();
              },
              icon: const Icon(Icons.chevron_left_rounded),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Obx(() {
              if (controller.channel.value != null) {
                BetterPlayerDataSource dataSource = BetterPlayerDataSource(
                  BetterPlayerDataSourceType.network,
                  controller.channel.value!.url!,
                  cacheConfiguration:
                      const BetterPlayerCacheConfiguration(useCache: false),
                );
                _betterPlayerController =
                    BetterPlayerController(betterPlayerConfiguration);
                _betterPlayerController.setupDataSource(dataSource);
                return BetterPlayer(controller: _betterPlayerController);
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
