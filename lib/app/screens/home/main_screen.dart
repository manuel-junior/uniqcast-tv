import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/screens/home/channel_detail_screen.dart';

import '../../../utils/constants.dart';
import '../../controller/controller.dart';
import '../../data/models/home/channel_model.dart';

class MainScreen extends StatelessWidget {
  final ChannelController controller = ChannelController.to;
  final AuthController authController = AuthController.to;

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: kPrimaryColor,
              leadingWidth: 150.0,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Hello,",
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      "${authController.userData.value?.username.capitalizeFirst}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
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
                    onPressed: () async {
                      await authController.logout();
                    },
                    icon: const Icon(Icons.logout_rounded),
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
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
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
                              Hero(
                                tag: currentChannel.name! + currentChannel.lang,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 216, 216, 216),
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        currentChannel.getLogoURL(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: currentChannel.name! +
                                              currentChannel.lang +
                                              currentChannel.template,
                                          transitionOnUserGestures: true,
                                          child: Material(
                                            type: MaterialType
                                                .transparency, // likely needed
                                            child: Text(
                                              currentChannel.name!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          currentChannel.lang.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: FloatingActionButton(
                                        heroTag: currentChannel.name,
                                        backgroundColor:
                                            const Color(0xff4A97C5),
                                        child: const Icon(
                                            Icons.play_arrow_rounded),
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
}
