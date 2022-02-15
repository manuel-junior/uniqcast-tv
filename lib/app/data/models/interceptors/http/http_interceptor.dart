import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../controller/account/auth_controller.dart';
import '../../../../helpers/http/http_error.dart';

class HttpInterceptor {
  final http.Client client;
  final AuthController controller = Get.find<AuthController>();

  HttpInterceptor(this.client);

  Future<Map?> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final headers = {
      "Content-Type": "application/json",
      "accept": "aplication/json",
    };

    // if the current user is loggin and has token, we pass the token
    if (controller.isLoggedIn) {
      if (controller.token.isNotEmpty) {
        headers["Authorization"] = 'Bearer ${controller.token}';
      }
    }
    final jsonBody = body;

    var response = http.Response("", 500);

    try {
      if (method == 'post') {
        print("Aquii post");
        print(jsonBody.toString());

        response = await client.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(jsonBody),
        );
      } else {
        print("Aquii get");
        response = await client.post(
          Uri.parse(url),
          headers: headers,
        );
      }
    } catch (error) {
      print(error.toString());
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  Future<Map?> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty
          ? jsonDecode(response.body)
          : throw HttpError.notData;
    } else if (response.statusCode == 204) {
      throw HttpError.notData;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    }
    // if the requested URL returns 401, we logout the current user
    else if (response.statusCode == 401) {
      //throw HttpError.unauthorized;
      await controller.logout();
    } else if (response.statusCode == 403) {
      print(response.body.toString());
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
    return null;
  }
}
