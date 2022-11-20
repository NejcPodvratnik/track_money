import 'dart:convert';

import 'package:http/http.dart' as http;

//Models
import 'package:frontend/models/authentication.dart';
import 'package:frontend/models/user_info.dart';

class UserAPI {
  static Future<Authentication> signup(
      String email, String name, String surname, String password) async {
    Uri url = Uri.parse("http://localhost:8000/api/signup");
    var res = await http.post(
      url,
      body: {
        "email": email,
        "name": name,
        "surname": surname,
        "password": password,
      },
    );
    if (res.statusCode != 201) {
      throw jsonDecode(res.body)["message"];
    }
    return authenticationFromJson(res.body);
  }

  static Future<Authentication> authenticate(
      String email, String password) async {
    Uri url = Uri.parse("http://localhost:8000/api/authenticate");
    var res = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)["message"];
    }
    return authenticationFromJson(res.body);
  }

  static Future<UserInfo?> find(String? id) async {
    Uri url = Uri.parse("http://localhost:8000/api/user/$id");
    var res = await http.get(url);
    if (res.statusCode != 200) throw jsonDecode(res.body)["message"];
    return res.body != "null" ? userInfoFromJson(res.body) : null;
  }
}
