class LoginPayload {
  final String username;
  final String password;

  LoginPayload(this.username, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = username;
    data['password'] = password;
    return data;
  }
}
