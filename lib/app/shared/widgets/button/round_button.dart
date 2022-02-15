import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color color;
  final String text;
  final EdgeInsets? padding;
  final VoidCallback onTap;
  final double? fontSize;

  const RoundedButton({
    Key? key,
    required this.backgroundColor,
    required this.color,
    required this.text,
    this.padding,
    required this.onTap,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      onTap: onTap,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: fontSize ?? 14,
                color: color,
              ),
        ),
      ),
    );
  }
}
