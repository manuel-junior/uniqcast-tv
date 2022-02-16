import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/screens/home/channel_detail_screen.dart';
import 'package:uniq_cast_tv/app/screens/home/drawer.dart';

import '../../../utils/constants.dart';
import '../../controller/controller.dart';
import '../../data/models/home/channel_model.dart';
import '../../shared/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  final ChannelController controller = ChannelController.to;
  final AuthController authController = AuthController.to;

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: CustomDrawer(
        controller: authController,
      ),
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: kPrimaryColor,
              leadingWidth: 60.0,
              pinned: true,
              leading: Container(
                width: 40,
                margin: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: IconButton(
                  color: kPrimaryColor,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu_sharp),
                ),
              ),
              actions: [
                Container(
                  width: 40,
                  margin: const EdgeInsets.only(right: 20.0, top: 8, bottom: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: IconButton(
                    color: kPrimaryColor,
                    onPressed: () async {},
                    icon: const Icon(Icons.search_outlined),
                  ),
                ),
              ],
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "TV channels",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
            Obx(
              // if our channels list is empty, we show circular progress indicator
              //else we display all channels
              () => controller.channels.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: controller.channels.length,
                      itemBuilder: (context, index) {
                        Channel currentChannel = controller.channels[index];
                        return channelCard(currentChannel);
                      },
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container channelCard(Channel currentChannel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff00577c),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 4,
            blurRadius: 8.0,
            color: Color.fromARGB(97, 0, 87, 124),
          )
        ],
      ),
      child: Row(
        children: [
          ChannelIconCard(
            height: 70,
            width: 70,
            channel: currentChannel,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChannelHeroText(
                      channel: currentChannel,
                      fontSize: 18,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      currentChannel.lang.toUpperCase().replaceAll("_", "-"),
                      style: const TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
                // only displays play button if the current
                // device is a mobile phone
                if (GetPlatform.isIOS || GetPlatform.isAndroid)
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FloatingActionButton(
                      heroTag: currentChannel.name,
                      backgroundColor: const Color(0xff4A97C5),
                      child: const Icon(Icons.play_arrow_rounded),
                      onPressed: () {
                        Get.to(
                          () => ChannelDetailScreen(
                            channel: currentChannel,
                          ),
                          curve: Curves.easeInOutBack,
                          transition: Transition.fadeIn,
                        );
                      },
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
