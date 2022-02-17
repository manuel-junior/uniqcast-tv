import 'package:flutter/material.dart';

import '../../../data/models/home/channel_model.dart';

class ChannelLogoCard extends StatelessWidget {
  final double height;
  final double width;
  final Channel channel;
  final EdgeInsets? margin;
  const ChannelLogoCard({
    Key? key,
    required this.height,
    required this.width,
    required this.channel,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: channel.getTag(),
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 216, 216),
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage(
              channel.getLogoURL(),
            ),
          ),
        ),
      ),
    );
  }
}
