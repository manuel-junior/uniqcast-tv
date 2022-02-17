import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  static final _box = GetStorage('bookedChannels');
  static String tag = '#channelCtrl';

  final ChannelRepository _repository;
  final AuthController _authController;
  final Rx<Channel?> channel = Rx<Channel?>(null);
  final RxList<Channel> channels = RxList<Channel>();
  final RxList<Channel> bookMarkedchannels = RxList<Channel>();

  ChannelController(this._repository, this._authController);

  /*
  we only call this function if the current user is authenticated and
  we are building main screen
  */
  getBookMarkedchannels() {
    for (Map item in _box.getValues().whereType()) {
      bookMarkedchannels.add(Channel.fromJson(item));
    }
  }

  /* 
  Either we are deleting or adding a channel, we have to update our
  bookMarkedchannels list and our local storage
  */
  bookMarkChannel(Channel channel) {
    Map? hasChannel = _box.read<Map<String, dynamic>>(channel.name!);

    if (hasChannel != null) {
      _box.remove(channel.name!);
      bookMarkedchannels.add(channel);
    } else {
      _box.write(channel.name!, channel.toJson());
      _deleteChannelFromList(channel);
    }
  }

  /* 
  this funtion is used to delete bookMarkedchannel from bookMarkedchannels list
  when bookMarkChannel() is call
 */
  _deleteChannelFromList(Channel channel) {
    bool canDelete = false;

    for (var item in bookMarkedchannels) {
      if (channel.name! == item.name) {
        canDelete = true;
      }
    }

    if (canDelete) {
      int index = bookMarkedchannels.indexOf(channel);
      bookMarkedchannels.removeAt(index);
    }
    bookMarkedchannels.refresh();
  }

  bool isBookMarked(Channel channel) {
    for (var item in bookMarkedchannels) {
      if (channel.name! == item.name) {
        return true;
      }
    }
    return false;
  }

  @override
  void onReady() async {
    if (channels.isEmpty && _authController.isLoggedIn) {
      await getChannels();
    }
    getBookMarkedchannels();
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
        await showError(AplicationError.connection);
      } else {
        await showError(AplicationError.unexpected);
      }
    }
  }

  Future<void> getChannelData(int id) async {
    try {
      channel.value = await _repository.getChannelData(id);
    } catch (error) {
      if (error == HttpError.unauthorized || error == HttpError.forbidden) {
        await showError(AplicationError.invalidCredentials);
      } else if (error == HttpError.noConnection) {
        await showError(AplicationError.connection);
      } else {
        await showError(AplicationError.unexpected);
      }
    }
  }

  /* 
  we call this method when we'are logginOut or 
  when we press delete all button on bookmarked list page
  */
  Future<void> clearSavedChannels() async {
    bookMarkedchannels.clear();
    await _box.erase();
  }
}
