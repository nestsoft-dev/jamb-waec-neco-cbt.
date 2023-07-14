import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<User?> register(String email, String password,BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Account Created'),
        backgroundColor: Colors.green,
      ));
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> login(String email, String password,BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login was successful'),
        backgroundColor: Colors.green,
      ));
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  
}
