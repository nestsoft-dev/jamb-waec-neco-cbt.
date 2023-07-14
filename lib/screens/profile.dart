import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  String name = '';
  int points = 0;
  String email = '';
  bool gottenData = true;

  connercted() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // setState(() {
          name = data["UserName"];
          points = data["points"];
          email = data['Email'];

          name = data["UserName"];
          points = data["points"];
          //  money = data['money'];
          // showMoney = money.toStringAsFixed(2);
          setState(() {
            gottenData = false;
          });
          // });
          print("HomePage Name: $name, balance is $points");

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  getDatas() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          name = data["UserName"];
          points = data["points"];
          email = data['Email'];

          print("Name: $name, balance is $points");

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getDatas();
    connercted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "My Profile",
            style: TextStyle(color: Color.fromARGB(255, 0, 61, 31)),
          )),
      body: gottenData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: getDatas(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 0, 61, 31),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${name[0]}',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 61, 31),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      email,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Total points: $points',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Follow Us ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 15, left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var whatsappAndroid = Uri.parse(
                                          "https://www.facebook.com/profile.php?id=100088829409741");
                                      // if (await canLaunchUrl(whatsappAndroid)) {
                                      //   await launchUrl(whatsappAndroid);
                                      // } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text("Something wrong"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                    //  }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: FaIcon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color: Colors.white,
                                    ),
                                  ),
                                  CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: FaIcon(
                                      FontAwesomeIcons.twitter,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.user,
                                          color: Color.fromARGB(255, 0, 61, 31),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Privacy Policy',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.arrowRightLong,
                                      color: Color.fromARGB(255, 0, 61, 31),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          //help and support

                          GestureDetector(
                            onTap: () async {
                              var whatsapp = "+2349138473122";
                              var whatsappAndroid = Uri.parse(
                                  "whatsapp://send?phone=$whatsapp&text=Hello Hello i need help from jambite");
                              // if (await canLaunchUrl(whatsappAndroid)) {
                              //   await launchUrl(whatsappAndroid);
                              // } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "WhatsApp is not installed on the device"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              // }
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.user,
                                            color:
                                                Color.fromARGB(255, 0, 61, 31),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Help & Support',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.arrowRightLong,
                                        color: Color.fromARGB(255, 0, 61, 31),
                                      ),
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          GestureDetector(
                            onTap: () async {
                              var whatsapp = "+2349138473122";
                              var whatsappAndroid = Uri.parse(
                                  "whatsapp://send?phone=$whatsapp&text=Hello i would love to know more about Jambite");
                              // if (await canLaunchUrl(whatsappAndroid)) {
                              //   await launchUrl(whatsappAndroid);
                              // } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "WhatsApp is not installed on the device"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              // }
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.addressBook,
                                            color:
                                                Color.fromARGB(255, 0, 61, 31),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'About Us',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.arrowRightLong,
                                        color: Color.fromARGB(255, 0, 61, 31),
                                      ),
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          //chat with us whatsapp

                          GestureDetector(
                            onTap: () async {
                              var whatsapp = "+2349138473122";
                              var whatsappAndroid = Uri.parse(
                                  "whatsapp://send?phone=$whatsapp&text=Hello am a user of Jambite, I have few questions");
                              // if (await canLaunchUrl(whatsappAndroid)) {
                              //   await launchUrl(whatsappAndroid);
                              // } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "WhatsApp is not installed on the device"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              // }
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.message,
                                            color:
                                                Color.fromARGB(255, 0, 61, 31),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Chat with us',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.arrowRightLong,
                                        color: Color.fromARGB(255, 0, 61, 31),
                                      ),
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          //share
                          GestureDetector(
                            onTap: () {
                            //   Share.share(
                            //       'Hey friend check out these amazing app that pays you to study for exams with airtime or data. \n Download from the link below https://play.google.com/store/apps/details?id=com.netsoft.jambforall');
                            //
                             },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.share,
                                            color:
                                                Color.fromARGB(255, 0, 61, 31),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Share with A friend',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.arrowRightLong,
                                        color: Color.fromARGB(255, 0, 61, 31),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              'Developed by Netsoft-Technologies (Netsoft-Developers) \❤')
                        ],
                      ),
                    ),
                  );
                }
              }),
    );
  }
}
