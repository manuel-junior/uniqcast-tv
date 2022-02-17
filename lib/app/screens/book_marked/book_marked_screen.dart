import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/data/models/home/channel_model.dart';

import '../../../utils/constants.dart';
import '../../controller/controller.dart';
import '../../shared/widgets/widgets.dart';

class BookMarkedScreen extends StatelessWidget {
  BookMarkedScreen({Key? key}) : super(key: key);

  final ChannelController controller = ChannelController.to;

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
              leadingWidth: 80.0,
              pinned: true,
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
                      Get.back();
                    },
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                ),
              ),
              title: const Text(
                "Bookmarked channel",
              ),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Obx(
              // if our channels list is empty, we show circular progress indicator
              //else we display all channels
              () => controller.bookMarkedchannels.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.bookMarkedchannels.length,
                      itemBuilder: (context, index) {
                        Channel currentChannel =
                            controller.bookMarkedchannels[index];
                        return channelCard(currentChannel);
                      },
                    )
                  : SizedBox(
                      height: Get.height * 0.50,
                      width: Get.width * 0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Text(
                              "Empty list!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "You have no saved channel at this moment.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
