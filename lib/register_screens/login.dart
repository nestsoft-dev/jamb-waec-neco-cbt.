import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../auths/auth_firebase.dart';
import '../screens/navigation/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  bool isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _email.dispose();

    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.fromARGB(255, 216, 255, 217),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'assets/login_sec.json',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                'Provide Login Details Below',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),

              //login email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 203, 252, 208),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 216, 215, 215).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.green,
                        size: 20,
                      ),
                      hintText: 'Enter Email address',
                      border: InputBorder.none,
                    ),
                    controller: _email,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              //password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 203, 252, 208),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 216, 215, 215).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: FaIcon(
                        FontAwesomeIcons.key,
                        color: Colors.green,
                        size: 20,
                      ),
                      hintText: 'Enter password',
                      border: InputBorder.none,
                    ),
                    controller: _password,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              //Login Button
              GestureDetector(
                onTap: () async {
                  if (_email.text == '' || _password.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please Check details and try again'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    setState(() {
                      isloading = true;
                    });
                    AuthService()
                        .login(_email.text, _password.text, context)
                        .then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationsPage()));
                    });
                  }
                },
                child: isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Login Account',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Hey There Student!',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      RotateAnimatedText(
                          'Are you planing on Getting High Grades?',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      RotateAnimatedText('Login and Explore the difference',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 10,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
