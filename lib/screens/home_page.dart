import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:chips_choice/chips_choice.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';
import 'package:practicepal/screens/question_screen.dart';
import 'package:practicepal/screens/screen_interfaced.dart';
import 'package:practicepal/screens/swipe_screen.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'heatmap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool gottenData = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  bool setallData = true;
  String name = '';
  String showMoney = '';
  var points;
  var money;
  //BannerAd? _bannerAd;
  bool _isLoaded = false;
  
  getUserDetails() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // setState(() {

          setallData = false;
          name = data["UserName"];
          points = data["points"];
          money = data['money'];
          showMoney = money.toStringAsFixed(2);

          // });
          print("HomePage Name: $name, balance is $points");

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  connercted() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;

          setallData = false;
          name = data["UserName"];
          points = data["points"];
          money = data['money'];
          showMoney = money.toStringAsFixed(2);
          setState(() {
            gottenData = false;
          });

          print("HomePage Name: $name, balance is $points");

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  var selectedYearnQuestion;

  String selectedUtmeExamType = 'english';

  // RateMyApp rateMyApp = RateMyApp(
  //   preferencesPrefix: 'rateMyApp_',
  //   minDays: 0,
  //   minLaunches: 2,
  //   remindDays: 7,
  //   remindLaunches: 10,
  //   googlePlayIdentifier: 'com.netsoft.jambforall',
  // );

  @override
  void initState() {
    super.initState();
    getUserDetails();
    // loadAd();
    // loadAdint();
    connercted();
    // rateMyApp.init().then((_) {
    //   if (rateMyApp.shouldOpenDialog) {
    //     rateMyApp.showRateDialog(
    //       context,
    //       title: 'Rate this app', // The dialog title.
    //       message:
    //           'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
    //       rateButton: 'RATE', // The dialog "rate" button text.

    //       laterButton: 'MAYBE LATER',
    //       onDismissed: () =>
    //           rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    //       ignoreNativeDialog: Platform
    //           .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
    //       dialogStyle: const DialogStyle(),
    //     );
    //   }
    // });
  }

  var images = [
    'assets/first.png',
    'assets/second.png',
    'assets/third.png',
    'assets/furth.png',
  ];

  List<Map<String, dynamic>> courses = [
    {
      'subject': 'Accounting',
      'image': 'assets/accounting.png',
    },
    {
      'subject': 'English',
      'image': 'assets/english.png',
    },
    {
      'subject': 'Biology',
      'image': 'assets/biology.png',
    },
    {
      'subject': 'Chemistry',
      'image': 'assets/chemistry.png',
    },
    {
      'subject': 'Civiledu',
      'image': 'assets/civil.png',
    },
    {
      'subject': 'Commerce',
      'image': 'assets/com.png',
    },
    {
      'subject': 'CRK',
      'image': 'assets/crk.png',
    },
    {
      'subject': 'Currentaffairs',
      'image': 'assets/current.png',
    },
    {
      'subject': 'Economics',
      'image': 'assets/econ.png',
    },
    {
      'subject': 'Geography',
      'image': 'assets/geogrephy.png',
    },
    {
      'subject': 'History',
      'image': 'assets/history.png',
    },
    {
      'subject': 'Insurance',
      'image': 'assets/insurance.png',
    },
    {
      'subject': 'IRK',
      'image': 'assets/irk.png',
    },
    {
      'subject': 'Literature ',
      'image': 'assets/lit.png',
    },
    {
      'subject': 'Mathematics',
      'image': 'assets/maths.png',
    },
    {
      'subject': 'Physics',
      'image': 'assets/physics.png',
    },
  ];

  List<String> examType = ['utme', 'postutme', 'wassec', 'ssce'];

  List<String> years = [
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
  ];

  /// Loads a banner ad.
  ///
  // InterstitialAd? _interstitialAd;
  // void loadAdint() {
  //   InterstitialAd.load(
  //       adUnitId: 'ca-app-pub-7278030962540782/5821523225',
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (ad) {
  //           debugPrint('$ad loaded.');
  //           // Keep a reference to the ad so you can show it later.
  //           _interstitialAd = ad;
  //           Future.delayed(Duration(minutes: 2)).then((value) {
  //             _interstitialAd!.show();
  //           });

  //           // show inter ads
  //         },
  //         // Called when an ad request failed.
  //         onAdFailedToLoad: (LoadAdError error) {
  //           _interstitialAd!.dispose();
  //           debugPrint('InterstitialAd failed to load: $error');
  //         },
  //       ));
  // }

  // ///
  // void loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: 'ca-app-pub-7278030962540782/9760768232',
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad loaded.');
  //         setState(() {
  //           _isLoaded = true;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         debugPrint('BannerAd failed to load: $err');
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   )..load();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 227, 253, 251),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.trophy,
                    ),
                    Text(
                      '$points',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: gottenData
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: FutureBuilder(builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Welcome',
                                style: TextStyle(
                                    color: Colors.black12,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$name',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 12, 11, 11),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //first box
                            InkWell(
                              onTap: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Oops...',
                                  text: 'Not available in current version',
                                );
                              },
                              child: Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 201, 255, 250),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.newspaper,
                                        color:
                                            Color.fromARGB(255, 56, 235, 220),
                                        size: 70,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('jamb News'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //second box
                            // add alert box with cuttoff mark 200
                            InkWell(
                              onTap: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.info,
                                  text:
                                      'Jamb cut of mark for 2023 is 140. \n 2024 jamb mark is 180',
                                );
                              },
                              child: Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 201, 255, 250),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.graduationCap,
                                        color:
                                            Color.fromARGB(255, 56, 235, 220),
                                        size: 70,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Cut-off marks'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //third box
                            InkWell(
                              onTap: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.info,
                                  title: 'Jamb News',
                                  text: 'Check your jamb portal',
                                );
                              },
                              child: Container(
                                width: 110,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 201, 255, 250),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.bookmark,
                                        color:
                                            Color.fromARGB(255, 56, 235, 220),
                                        size: 70,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('jamb syllabus'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Swap Money for Data/Airtime',
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SwapMoney()));
                                  },
                                  child: Text('\₦$showMoney'))
                            ],
                          ),
                        ),

                        Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection:
                                  axisDirectionToAxis(AxisDirection.right),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: 10,
                                    ),
                                    height: 200,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: AssetImage('${images[index]}'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        //scrollview of courses
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection:
                                  axisDirectionToAxis(AxisDirection.right),
                              itemCount: courses.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //start selected exam

                                    // Generate a random index

                                    //examType
                                    int randomIndex =
                                        Random().nextInt(years.length);
                                    // Get the item at the random index
                                    String randomItem = years[randomIndex];
                                    print('Random year is $randomItem');

                                    //random exam type
                                    int randomTypeIndex =
                                        Random().nextInt(examType.length);
                                    // Get the item at the random index
                                    String randomTypeItem =
                                        examType[randomTypeIndex];
                                    print('Random type is $randomTypeItem');
                                    String subjectName =
                                        courses[index]['subject'];
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Questions(
                                        40,
                                        // year: randomItem,
                                        year: randomItem,
                                        subject: '${subjectName.toLowerCase()}',
                                        type: randomTypeItem,
                                        selectedTime: 20,
                                        url:
                                            'https://questions.aloc.com.ng/api/v2/q/40?subject=${subjectName.toLowerCase()}',
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      height: 200,
                                      width: 230,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                '${courses[index]['image']}'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 135,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 80, 249, 255),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${courses[index]['subject']}',
                                                    style:
                                                        TextStyle(fontSize: 19),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text('Start Exam',
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Exams Practice & CBT Test',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Interface(
                                              examType: 'utme',
                                            )));
                              },
                              child: Container(
                                width: 180,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 61, 31),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 55,
                                        backgroundImage:
                                            AssetImage('assets/jamb_icon.jpeg'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'UTME CBT Test',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Interface(
                                              examType: 'postutme',
                                            )));
                              },
                              child: Container(
                                width: 180,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 61, 31),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 55,
                                        backgroundImage:
                                            AssetImage('assets/jamb_icon.jpeg'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Post UTME',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // if (_bannerAd != null)
                        //   SizedBox(
                        //     width: _bannerAd!.size.width.toDouble(),
                        //     height: _bannerAd!.size.height.toDouble(),
                        //     child: AdWidget(ad: _bannerAd!),
                        //   )
                       // else
                          SizedBox(),

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Interface(
                                              examType: 'wassec',
                                            )));
                              },
                              child: Container(
                                width: 180,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 61, 31),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 55,
                                        backgroundImage:
                                            AssetImage('assets/waec_icon.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'WAEC CBT Test',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Interface(
                                              examType: 'ssce',
                                            )));
                              },
                              child: Container(
                                width: 180,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 61, 31),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 55,
                                        backgroundImage:
                                            AssetImage('assets/neco_icon.jpg'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'NECO CBT Test',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                }),
              )

        //                 //Exam type

        //                 //second row

        //                 //show banner ads

        //               ],
        //             ),
        //           ),
        //         );
        //       }
        //     }),
        );
  }
}
