import 'dart:convert';

//Models
import 'package:frontend/models/user_info.dart';

Authentication authenticationFromJson(String str) =>
    Authentication.fromJson(json.decode(str));

String authenticationToJson(Authentication data) => json.encode(data.toJson());

class Authentication {
  Authentication({
    required this.message,
    required this.token,
    required this.userInfo,
    required this.expiresAt,
  });

  final String message;
  final String token;
  final UserInfo userInfo;
  final int expiresAt;

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        message: json["message"],
        token: json["token"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
        expiresAt: json["expiresAt"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "userInfo": userInfo.toJson(),
        "expiresAt": expiresAt,
      };
}
