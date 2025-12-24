import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user data

  Future<void> saveUser(String uid, String name, String email) async{
    await _db
    .collection('users')
    .doc(uid)
    .set(
      {
        'name': name,
        'email': email
      }
    );
  }


  // Get user data

  Future<DocumentSnapshot> getUser(String uid) async{
    return await _db
    .collection('users')
    .doc(uid)
    .get();
  }
}