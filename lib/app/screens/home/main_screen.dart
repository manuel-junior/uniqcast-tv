import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';

class MainScreen extends StatelessWidget {
  final ChannelController controller = ChannelController.to;
  final AuthController authController = AuthController.to;

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leadingWidth: 100.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Hello,"),
                Text("${authController.userData.value?.username}"),
              ],
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: IconButton(
                onPressed: () async {
                  await authController.logout();
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Obx(
            // if our channels list is empty, we show circular progress indicator
            //else we display all channels
            () => controller.channels.isNotEmpty
                ? Center(
                    child: Text("${controller.channels.length}"),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ),
        ),
      ],
    ));
  }
}
