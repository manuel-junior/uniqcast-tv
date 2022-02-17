import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/screens/home/custom_drawer.dart';

import '../../../utils/constants.dart';
import '../../controller/controller.dart';
import '../../data/models/home/channel_model.dart';
import '../../shared/widgets/channel/channel_card.dart';

class MainScreen extends StatelessWidget {
  final ChannelController controller = ChannelController.to;
  final AuthController authController = AuthController.to;

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: CustomDrawer(
        authController: authController,
        channelController: controller,
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
              actions: const [
                // Container(
                //   width: 40,
                //   margin: const EdgeInsets.only(right: 20.0, top: 8, bottom: 8),
                //   decoration: const BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //   ),
                //   child: IconButton(
                //     color: kPrimaryColor,
                //     onPressed: () async {},
                //     icon: const Icon(Icons.search_outlined),
                //   ),
                // ),
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
                      height: MediaQuery.of(context).size.height * 0.10,
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
