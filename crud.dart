import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  late String id;
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    )..id = doc.id;
  }
}

class UserService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    await usersCollection.add(user.toJson());
  }

  Stream<List<User>> getUser() {
    return usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((docs) => User.fromFirestore(docs)).toList();
    });
  }

  Future<void> updateUser(User user) async {
    await usersCollection.doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(User user) async {
    await usersCollection.doc(user.id).delete();
  }
}
