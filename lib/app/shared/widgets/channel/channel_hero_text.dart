import 'package:flutter/material.dart';
import 'package:uniq_cast_tv/app/data/models/home/channel_model.dart';

class ChannelHeroText extends StatelessWidget {
  final Channel channel;
  final double fontSize;

  const ChannelHeroText(
      {Key? key, required this.channel, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: channel.getTag2(),
      transitionOnUserGestures: true,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          channel.name!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
