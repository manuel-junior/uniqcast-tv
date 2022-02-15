import 'package:get/get.dart';
import 'package:http/http.dart';

import '../controller/account/auth_controller.dart';
import '../controller/home/home_controller.dart';
import '../data/repository/auth/auth_repository.dart';
import '../data/repository/home/channel_repository.dart';

// Base URL
const String baseURL = "http://devel.uniqcast.com:3001/";

// Channel's logo URL
const String logoURL = "https://devel/uniqcast.com/samples/logos/";

// Base URL Endpoints
const String _loginPath = "auth/local";
const String _homePath = "channels/";
const String channelDetailPath = "channels/"; //<channel ID>

// Http client
final Client httpClient = Client();

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () =>
          ChannelRepository(client: httpClient, url: baseURL, path: _homePath),
      fenix: true,
    );

    Get.lazyPut(
      () => ChannelController(
        Get.find<ChannelRepository>(),
        Get.find(),
      ),
      fenix: true,
      tag: ChannelController.tag,
    );

    Get.put<AuthRepository>(
      AuthRepository(
        client: httpClient,
        url: baseURL,
        path: _loginPath,
      ),
      permanent: true,
    );

    Get.put<AuthController>(
      AuthController(Get.find<AuthRepository>()),
      permanent: true,
    );
  }
}
