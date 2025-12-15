import 'package:flutter/material.dart';
import 'package:week4_task/models/user_model.dart';
import 'package:week4_task/services/user_service.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User data fetching from an API",
          ),
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
          ),
      body: FutureBuilder<UserModel>(
        future: UserService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator()
              );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
              "Error: ${snapshot.error}",
              style: TextStyle(
                color: Colors.red
                ),
            ));
          }

          final user = snapshot.data!;

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                Icons.person, 
                size: 80
                ),

                SizedBox(height: 15),
                
                Text(
                user.name,
                style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  )
                  ),
                Text(user.email),
              ],
            ),
          );
        },
      ),
    );
  }
}
