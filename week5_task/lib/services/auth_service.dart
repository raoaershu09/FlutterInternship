import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up

  Future<User?> signup(String email, String password) async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password
      );
      return userCredential.user;
  }


  // Login

  Future<User?> login(String email, String password)async{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password
    );

    return userCredential.user;
  }


  // Current User

  User? get currentUser => _auth.currentUser;


  // Logout

  Future<void> logout() async {
    await _auth.signOut();
  }

}