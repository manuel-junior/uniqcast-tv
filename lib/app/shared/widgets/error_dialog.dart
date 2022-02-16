import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/application/aplication.dart';

showError(AplicationError error) {
  String? title;
  String? subTitle;

  var accountErrorIcon = const Icon(Icons.person, color: Colors.red);
  var appErrorIcon = const Icon(Icons.settings, color: Colors.black87);

  var accountErrorTextColor = Colors.red;
  var appErrorTextColor = Colors.black87;

  late Icon icon;
  late Color textColor;

  if (error == AplicationError.invalidCredentials) {
    icon = accountErrorIcon;
    textColor = accountErrorTextColor;
    title = "Access denied";
    subTitle = "Please, provide a valid user cretendials";
  } else if (error == AplicationError.connection) {
    title = "Oops! Can't move forward!";
    subTitle = "It seems your internet is slow or not working!";
    icon = const Icon(Icons.network_wifi, color: Colors.red);
    textColor = appErrorTextColor;
  } else {
    icon = appErrorIcon;
    textColor = appErrorTextColor;
    title = "Something went wrong";
    subTitle = "Please, try again";
  }
  Future.delayed(const Duration(seconds: 0), () {
    Get.snackbar(
      title!,
      subTitle!,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[50],
      borderRadius: 15,
      maxWidth: 400,
      margin: const EdgeInsets.all(40),
      colorText: textColor,
      duration: const Duration(seconds: 6),
      isDismissible: false,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  });
}
