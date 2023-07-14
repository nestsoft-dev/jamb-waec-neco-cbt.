import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:practicepal/screens/result.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;


import '../options.dart';
import 'calulator.dart';
import 'navigation/navigation.dart';

class Questions extends StatefulWidget {
  Questions(int i,
      {super.key,
      required this.year,
      required this.subject,
      required this.type,
      required this.selectedTime,
      required this.url});
  late String year;
  late String subject;
  late String type;
  late int lenth;
  late int selectedTime;
  late String url;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int _currentPageIndex = 0;
  int _score = 0;

  List<dynamic> _quizData = [];
  // TextToSpeech tts = TextToSpeech();
  bool loaded = true;

  int countDown = 40;
  Timer? timer;
  bool ispressed = false;

  startTimer() {
    // final player = AudioPlayer();
    // player.play(AssetSource('jsons/td_whistle.wav'));
    // setState(() {
    //   countDown = widget.selectedTime;
    //   // start = true;
    //   // _isruning = true;
    // });
    timer = Timer.periodic(Duration(minutes: 1), (_) {
      if (countDown > 0) {
        setState(() {
          countDown--;
        });
        if (countDown < 5) {
          // final player = AudioPlayer();
          // player.play(AssetSource('jsons/td_tick.mp3'));
        }
      } else if (countDown == 0) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Results(
                      url: '${widget.url}',
                    )));

        // final player = AudioPlayer();
        // player.play(AssetSource('jsons/td_whistle.wav'));
        timer?.cancel();
        setState(() {
          // _isruning = false;
        });
      }
    });
  }

  getData() async {
    print('url is ${widget.url}');
    var questions = await http.get(Uri.parse('${widget.url}'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'AccessToken': 'ALOC-de08837978fd45c30861'
    }).then((value) {
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        setState(() {
          _quizData = data['data'];

          loaded = false;
          print(_quizData);
        });
        //startTimer();
        print(data['data']);
        print(_quizData);
      } else {
        print(data.toString());
        print('something went wrong Question');
      }
    });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var points;
  var money;
  var wonMoney;
  getFirebaseData() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);
    try {
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // setState(() {

          points = data["points"];
          money = data['money'];

          // });

          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } catch (e) {}
  }

  // RewardedAd? _rewardedAd;
  // void loadAdR() {
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-7278030962540782/1996159984',
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (ad) {
  //           ad.fullScreenContentCallback = FullScreenContentCallback(
  //               // Called when the ad showed the full screen content.
  //               onAdShowedFullScreenContent: (ad) {},
  //               // Called when an impression occurs on the ad.
  //               onAdImpression: (ad) {},
  //               // Called when the ad failed to show full screen content.
  //               onAdFailedToShowFullScreenContent: (ad, err) {
  //                 // Dispose the ad here to free resources.
  //                 ad.dispose();
  //               },
  //               // Called when the ad dismissed full screen content.
  //               onAdDismissedFullScreenContent: (ad) {
  //                 // Dispose the ad here to free resources.
  //                 ad.dispose();
  //               },
  //               // Called when a click is recorded for an ad.
  //               onAdClicked: (ad) {});
  //           debugPrint('$ad loaded.');
  //           // Keep a reference to the ad so you can show it later.
  //           _rewardedAd = ad;
  //         },
  //         // Called when an ad request failed.
  //         onAdFailedToLoad: (LoadAdError error) {
  //           debugPrint('RewardedAd failed to load: $error');
  //         },
  //       ));
  // }

  void uploadReward(points, money, wonMoney, int score) async {
    var npoints = score * 10;
    var updatePoints = npoints + points;

    var nmoney = npoints * 0.02;
    var totalMoney = money + nmoney;
    setState(() {
      wonMoney = npoints * 0.02;
    });

    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid);

    try {
      docRef.update({
        'points': updatePoints,
        'money': totalMoney,
      }).then((value) {
        // _rewardedAd!.show(
        //     onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        //   //TODO add points
        //   // Reward the user for watching an ad.
        // });
      });
      // .then(
      //   // (DocumentSnapshot doc) {
      //   //   final data = doc.data() as Map<String, dynamic>;
      //   //   // setState(() {

      //   //   points = data["points"];
      //   //   money = data['money'];

      //   //   // });
      //   //   uploadReward(points, money, wonMoney, _score);

      //   //   // ...
      //   // },
      //   // onError: (e) => print("Error getting document: $e"),
      // );
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getData();
    //loadAdR();
    getFirebaseData();
    double pitch = 1.0;
    // tts.setPitch(pitch);
    // String language = 'en-US';
    // tts.setLanguage(language);
  }

  var isAnswer;

  void _checkAnswer(String selectedOption) {
    if (_quizData[_currentPageIndex]['answer'] == selectedOption) {
      print('correct');
      setState(() {
        _score++;
      });
      print('correct $_score');
      print('${_quizData[_currentPageIndex]['answer']}');
    }
    _goToNextQuestion();
  }

  PageController _firstcontroller = PageController(initialPage: 0);
  final List<Option> options = [];
  int _selectedIndex = -1;

  void _goToNextQuestion() {
    print('next screen');
    if (_currentPageIndex < _quizData.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    } else {
      uploadReward(points, money, wonMoney, _score);
      // Quiz completed, show result or navigate to next page
      // You can customize this part based on your app's logic
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('${widget.subject} study for ${widget.type} is Completed'),
            content: Text('Your score: $_score amount won $wonMoney'),
            actions: [
              TextButton(
                onPressed: () {
                  // TODO: Handle action on quiz completion
                  // This could be navigating to another page or resetting the quiz
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationsPage()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.subject.toUpperCase()} All exam type ${widget.year}',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Calculator()));
                },
                child: CircleAvatar(
                  child: Icon(
                    FontAwesomeIcons.calculator,
                  ),
                ),
              ),
            )
          ],
        ),
        body: loaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: PageView.builder(
                      itemCount: _quizData.length,
                      controller:
                          PageController(initialPage: _currentPageIndex),
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Question ${index + 1}/${_quizData.length}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      // => tts.speak(
                                      //     '${_quizData[index]['question']}'),
                                      child: Icon(
                                        Icons.volume_up_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${_quizData[index]['question']}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16),
                              if (_quizData[index]['image'] == '')
                                SizedBox()
                              else
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${_quizData[index]['image']}'),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: _quizData[index]['option']
                                    .entries
                                    .map<Widget>(
                                  (option) {
                                    return RadioListTile(
                                      title: Text(option.value),
                                      value: option.key,
                                      // groupValue: null,
                                      groupValue: isAnswer,
                                      onChanged: (value) {
                                        isAnswer = value;
                                        _checkAnswer(value);
                                        ispressed = true;
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () => _goToNextQuestion(),
                                      // onTap: ispressed
                                      //     ? index + 1 == _quizData.length
                                      //         ? () {
                                      //             print(
                                      //                 'The final score is $_score');
                                      //             QuickAlert.show(
                                      //               context: context,
                                      //               type:
                                      //                   QuickAlertType.success,
                                      //               text:
                                      //                   'Transaction Completed Successfully!',
                                      //             );

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Results(
                                      //               url:
                                      //                   '${widget.url}',
                                      //             )));
                                      //           }
                                      //         : () {
                                      //             setState(() {
                                      //               ispressed = false;
                                      //             });
                                      //             // PageController(
                                      //             //         initialPage:
                                      //             //             _currentPageIndex)
                                      //             //     .nextPage(
                                      //             //         duration: Duration(
                                      //             //             milliseconds:
                                      //             //                 200),
                                      //             //         curve: Curves.linear);
                                      //             _firstcontroller.nextPage(
                                      //                 duration: Duration(
                                      //                     milliseconds: 200),
                                      //                 curve: Curves.linear);
                                      //           }
                                      //     : () {
                                      //         QuickAlert.show(
                                      //           context: context,
                                      //           type: QuickAlertType.error,
                                      //           title: 'Oops...',
                                      //           text: 'Select option',
                                      //         );
                                      //       },
                                      child: Container(
                                        height: 45,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          // border: Border.all(
                                          //     width: 1.3,
                                          //     color: Color.fromARGB(255, 0, 99, 180)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Swipe to right',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Center(
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CircularProgressIndicator(
                                        value: countDown / 40.0,
                                        strokeWidth: 12,
                                        color:
                                            Color.fromARGB(255, 227, 253, 251),
                                        backgroundColor: Colors.green,
                                      ),
                                      Center(
                                        child: Text(
                                          '$countDown',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 80,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // ElevatedButton(
                              //   child: Text('Submit'),
                              //   onPressed: () {
                              //     setState(() {
                              //       _selectedIndex = _quizData[index]['option']
                              //           .indexWhere(
                              //               (option) => option.isSelected);
                              //     });
                              //   },
                              // ),
                              // SizedBox(height: 20.0),
                              // ElevatedButton(
                              //   child: Text('Next'),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        );
                      }),
                ),
              ]));
  }
}
