import 'package:http/http.dart';

import '../../../helpers/application/aplication.dart';
import '../../../helpers/http/http.dart';

import '../../models/auth/login/login_payload.dart';
import '../../models/auth/login/login_response.dart';
import '../../models/interceptors/http/http_interceptor.dart';

class AuthRepository {
  final Client client;
  final String url;
  final String path;

  AuthRepository({
    required this.client,
    required this.url,
    required this.path,
  });

  Future<LoginResponse> login(LoginPayload payload) {
    HttpInterceptor _httpInterceptor = HttpInterceptor(client);
    final String fullURL = url + path;

    try {
      return _httpInterceptor
          .request(method: 'post', url: fullURL, body: payload.toJson())
          .then((res) {
        return LoginResponse.fromJson(res);
      });
    } on HttpError catch (error) {
      if (error == HttpError.unauthorized || error == HttpError.forbidden) {
        throw AplicationError.invalidCredentials;
      } else if (error == HttpError.noConnection) {
        throw AplicationError.unexpected;
      } else {
        throw AplicationError.unexpected;
      }
    }
  }
}
