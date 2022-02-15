import 'package:uniq_cast_tv/app/data/models/auth/account/user.dart';

class LoginResponse {
  final String token;
  final User user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<dynamic, dynamic> map) => LoginResponse(
        token: map["jwt"],
        user: User.fromJson(map["user"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['user'] = user.toJson();
    return data;
  }
}
