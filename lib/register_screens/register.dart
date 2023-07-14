import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../auths/auth_firebase.dart';
import '../screens/navigation/navigation.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _parentsemail = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _conpassword = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  bool isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _parentsemail.dispose();
    _password.dispose();
    _conpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 255, 217),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'assets/welcome.json',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome New User',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create account to access our services',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                      hintText: 'Enter full name',
                      border: InputBorder.none,
                    ),
                    controller: _username,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: FaIcon(
                        FontAwesomeIcons.mailBulk,
                        color: Colors.green,
                        size: 20,
                      ),
                      hintText: 'Enter Parent\'s/ guardian\'s email',
                      border: InputBorder.none,
                    ),
                    controller: _parentsemail,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                    controller: _password,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                      hintText: 'Confirm Password',
                      border: InputBorder.none,
                    ),
                    controller: _conpassword,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //botton
              GestureDetector(
                onTap: () async {
                  if (_username.text == '' ||
                      _email.text == '' ||
                      _password.text == '' ||
                      _conpassword.text == '' ||
                      _password.text != _conpassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please Cross check enteries'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    AuthService()
                        .register(_email.text, _password.text, context)
                        .then((value) async {
                      setState(() {
                        isloading = false;
                      });
                      await FirebaseFirestore.instance
                          .collection("UsersDetails")
                          .doc(firebaseAuth.currentUser!.uid)
                          .set({
                        "UserName": _username.text,
                        "Email": _email.text,
                        "Password": _password.text,
                        "parentsEmail": _parentsemail.text,
                        "points": 0,
                        "money": 0.0,
                      }).then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationsPage()));
                      });
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
                            'SignUp',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Already have an account?'),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.green,
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
