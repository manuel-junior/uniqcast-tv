import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uniq_cast_tv/app/data/models/auth/account/user.dart';
import 'package:uniq_cast_tv/app/shared/widgets/error_dialog.dart';
import 'package:uniq_cast_tv/utils/routes/app_routes.dart';

import '../../data/models/auth/login/login_payload.dart';
import '../../data/repository/auth/auth.dart';
import '../../helpers/application/aplication.dart';
import '../../helpers/http/http.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  static final _box = GetStorage('AppStore');
  final AuthRepository _repository;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthController(this._repository);

  final RxnString _token = RxnString(null);
  final Rxn<User> userData = Rxn<User>(null);

  String get token => _token.value ?? '';

  set token(String? t) {
    _token.value = t;
    if (GetUtils.isNull(t)) {
      _box.remove('token');
    } else {
      _box.write('token', t);
    }
  }

  set user(Map<String, dynamic>? data) {
    if (data != null) {
      userData.value = User.fromJson(data);
      _box.write('user', data);
    } else {
      _box.remove('user');
    }
  }

  bool get isLoggedIn => token.isNotEmpty;

  @override
  void onInit() {
    token = _box.read<String>('token');
    user = _box.read<Map<String, dynamic>>('user');
    super.onInit();
  }

  Future<bool> login() async {
    try {
      var l = await _repository.login(
        LoginPayload(userController.text, passwordController.text),
      );
      token = l.token;
      userData.value = l.user;
      user = l.user.toJson();
      userController.text = '';
      passwordController.text = '';
      Get.offAllNamed(Routes.home);
      return true;
    } catch (error) {
      if (error == HttpError.unauthorized || error == HttpError.forbidden) {
        await showError(AplicationError.invalidCredentials);
      } else if (error == HttpError.noConnection) {
        await showError(AplicationError.connection);
      } else {
        await showError(AplicationError.unexpected);
      }
      return false;
    } finally {}
  }

  Future<void> logout() async {
    token = null;
    user = null;
    Get.offAllNamed(Routes.login);
  }
}
