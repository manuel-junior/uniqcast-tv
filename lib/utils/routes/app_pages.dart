import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/bindings/initial_bindings.dart';

import '../../app/controller/account/auth_controller.dart';

import '../../app/screens/authentication/login/login.dart';
import '../../app/screens/home/home.dart';
import 'app_routes.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authCtrl = AuthController.to;
    return authCtrl.isLoggedIn ? const RouteSettings(name: Routes.home) : null;
  }
}

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      middlewares: [
        AuthGuard(),
      ],
    ),
    GetPage(
      name: Routes.home,
      page: () => MainScreen(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.channelDetail,
      page: () => const ChannelDetailScreen(),
    ),
  ];
}
