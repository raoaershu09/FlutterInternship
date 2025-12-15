import 'dart:convert';
import 'package:week4_task/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = "https://jsonplaceholder.typicode.com/posts";

  static Future<List<PostModel>> getPosts()async{
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json)=> PostModel.fromJson(json)).toList();
    } 
    else{
      throw Exception("Failed to load posts");
    }
  }
}