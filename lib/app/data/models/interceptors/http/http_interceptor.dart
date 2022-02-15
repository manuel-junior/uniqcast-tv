import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../controller/account/auth_controller.dart';
import '../../../../helpers/http/http_error.dart';

class HttpInterceptor {
  final http.Client client;
  final AuthController controller = Get.find<AuthController>();

  HttpInterceptor(this.client);

  Future<dynamic> request({
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
        response = await client.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(jsonBody),
        );
      } else {
        //print("Aquii get");
        //print(headers.toString());
        response = await client.get(
          Uri.parse(url),
          headers: headers,
        );
      }
    } catch (error) {
      if (error.toString().contains("Connection refused")) {
        throw HttpError.serverError;
      } else {
        throw HttpError.noConnection;
      }
    }

    return _handleResponse(response);
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
    if (statusCode == 200) {
      try {
        // Throw no data error if body does not have a valid data format
        Type? dataType = jsonDecode(response.body).runtimeType;
        debugPrint(dataType.toString());
        if (jsonDecode(response.body).isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          // Throw no data error if body is empty
          throw HttpError.notData;
        }
      } catch (e) {
        throw HttpError.notData;
      }
    } else if (statusCode == 204) {
      throw HttpError.notData;
    } else if (statusCode == 400) {
      throw HttpError.badRequest;
    }
    // if the requested URL returns 401 and user is loggIn, we logout the current user
    else if (statusCode == 401) {
      if (controller.isLoggedIn) {
        await controller.logout();
      }
      throw HttpError.unauthorized;
    } else if (statusCode == 403) {
      throw HttpError.forbidden;
    } else if (statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
    // return null;
  }
}
