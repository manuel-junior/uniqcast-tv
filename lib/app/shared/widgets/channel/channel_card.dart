import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/home/channel_model.dart';
import '../../../screens/home/home.dart';
import 'channel_hero_text.dart';
import 'channel_logo_card.dart';

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
        ChannelLogoCard(
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
