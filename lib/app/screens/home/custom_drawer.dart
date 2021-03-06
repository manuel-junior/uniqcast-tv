import 'package:flutter/material.dart';
import 'package:uniq_cast_tv/app/controller/controller.dart';
import 'package:uniq_cast_tv/utils/routes/app_routes.dart';

import '../../../utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  final AuthController authController;
  final ChannelController channelController;
  const CustomDrawer(
      {Key? key, required this.authController, required this.channelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hello,",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${authController.userData.value?.username.toUpperCase()}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          drawerTile(
            text: 'Bookmarked channel',
            icon: Icons.bookmark,
            onTap: () => Navigator.popAndPushNamed(context, Routes.bookMarked),
          ),
          const SizedBox(
            height: 10,
          ),
          drawerTile(
            text: 'Log Out',
            icon: Icons.logout_rounded,
            onTap: () async {
              channelController.clearSavedChannels();
              await authController.logout();
            },
          ),
        ],
      ),
    );
  }

  InkWell drawerTile(
      {required String text,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 20.0, top: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Icon(icon),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
