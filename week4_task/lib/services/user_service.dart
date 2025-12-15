import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:week4_task/models/user_model.dart';

class UserService {
  static const String url = "https://jsonplaceholder.typicode.com/users/1";

  static Future<UserModel> getUser() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to load users: Server returned ${response.statusCode}");
    }
  }
}
