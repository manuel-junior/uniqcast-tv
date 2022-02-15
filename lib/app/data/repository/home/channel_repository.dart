import 'package:http/http.dart';

import '../../../helpers/application/aplication.dart';
import '../../../helpers/http/http.dart';
import '../../models/home/channel_model.dart';
import '../../models/interceptors/http/http_interceptor.dart';

class ChannelRepository {
  final Client client;
  final String url;
  final String path;
  final HttpInterceptor _httpInterceptor;

  ChannelRepository({
    required this.client,
    required this.url,
    required this.path,
  }) : _httpInterceptor = HttpInterceptor(client);

  Future<List<Channel>> getChannels() async {
    final String fullURL = url + path;
    try {
      List res = await _httpInterceptor.request(method: 'get', url: fullURL);

      return List.from(res.map((value) => Channel.fromJson(value)));
    } on HttpError catch (error) {
      if (error == HttpError.unauthorized) {
        throw AplicationError.invalidCredentials;
      } else if (error == HttpError.noConnection) {
        throw AplicationError.unexpected;
      } else {
        throw AplicationError.unexpected;
      }
    }
  }

  Future<Channel> getChannelData(int channelId) async {
    final String fullURL = url + path + "$channelId";

    try {
      return await _httpInterceptor
          .request(method: 'get', url: fullURL)
          .then((res) {
        print(res);
        return Channel.fromJson(res!);
      });
    } on HttpError catch (error) {
      if (error == HttpError.unauthorized) {
        throw AplicationError.invalidCredentials;
      } else if (error == HttpError.noConnection) {
        throw AplicationError.unexpected;
      } else {
        throw AplicationError.unexpected;
      }
    }
  }
}
