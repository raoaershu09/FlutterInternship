import 'package:flutter/material.dart';
import 'package:week4_task/models/post_model.dart';
import 'package:week4_task/services/api_service.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts fetching data from an API",
        ),
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),
      ),
      body: 
      FutureBuilder<List<PostModel>>(
        future: ApiService.getPosts(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}"
              ),
            );
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(
                  posts[index].title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  posts[index].body,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            );
        }
        )
    );
  }
}