import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniq_cast_tv/app/data/models/home/channel_model.dart';

import '../../data/repository/home/channel.dart';
import '../../helpers/application/aplication.dart';
import '../../helpers/http/http.dart';
import '../../shared/widgets/error_dialog.dart';
import '../account/auth_controller.dart';

class ChannelController extends GetxController {
  static ChannelController to = Get.find(
    tag: ChannelController.tag,
  );

  static String tag = '#channelCtrl';

  final ChannelRepository _repository;
  final AuthController _authController;
  final Rx<Channel?> channel = Rx<Channel?>(null);
  final RxList<Channel> channels = RxList<Channel>();

  ChannelController(this._repository, this._authController);

  @override
  void onReady() async {
    if (channels.isEmpty && _authController.isLoggedIn) {
      await getChannels();
    }
    super.onReady();
  }

  Future<void> getChannels() async {
    try {
      channels.addAll(await _repository.getChannels());
    } catch (error) {
      debugPrint(error.toString());
      if (error == HttpError.unauthorized || error == HttpError.forbidden) {
        await showError(AplicationError.invalidCredentials);
      } else if (error == HttpError.noConnection) {
        // throw AplicationError.unexpected;
        await showError(AplicationError.connection);
      } else {
        await showError(AplicationError.unexpected);
      }
    }
  }

  Future<void> getChannelData(int id) async {
    try {
      //showLoadingIndicator();
      channel.value = await _repository.getChannelData(id);
      //hideLoadingIndicator();
    } catch (e) {
      //hideLoadingIndicator();
    }
  }
}
