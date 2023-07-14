import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

import '../register_screens/register.dart';
import 'navigation/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 8)).then((value) {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NavigationsPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Register()));
      }
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 255, 255),
      body: Center(
        child: Lottie.asset('assets/loading.json', height: 250),
      ),
    );
  }
}
