import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniq_cast_tv/utils/routes/app_routes.dart';

import '../../data/models/auth/login/login_payload.dart';
import '../../data/repository/auth/auth.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  static final _box = GetStorage('AppStore');
  final AuthRepository _repository;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthController(this._repository);

  final RxnString _token = RxnString(null);

  String get token => _token.value ?? '';

  set token(String? t) {
    _token.value = t;
    if (GetUtils.isNull(t)) {
      _box.remove('token');
    } else {
      _box.write('token', t);
    }
  }

  bool get isLoggedIn => token.isNotEmpty;

  assignTokenFromLocalStorage() async {
    token = _box.read<String>('token');
  }

  @override
  void onInit() {
    print("onInit");
    assignTokenFromLocalStorage();
    super.onInit();
  }

  Future<void> login() async {
    try {
      //showLoadingIndicator();
      var l = await _repository.login(
        LoginPayload(userController.text, passwordController.text),
      );
      token = l.token;
      userController.text = '';
      passwordController.text = '';
      Get.offAllNamed(Routes.home);
    } catch (e) {
      print(e.toString());
    } finally {
      //hideLoadingIndicator();
    }
  }

  Future<void> logout() async {
    token = null;
    Get.offAllNamed('/');
  }
}
