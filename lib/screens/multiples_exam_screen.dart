import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:practicepal/screens/result.dart';

import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:text_to_speech/text_to_speech.dart';

import 'calulator.dart';
import 'navigation/navigation.dart';

class MultipleExamScreen extends StatefulWidget {
  MultipleExamScreen(
      {super.key,
      required this.subjectsList,
      required this.firstsubject,
      required this.secondsubject,
      required this.thirdsubject,
      required this.fourthsubject,
      required this.examType,
      required this.year});
  List<String> subjectsList;
  String firstsubject;
  String secondsubject;
  String thirdsubject;
  String fourthsubject;
  String examType;
  String year;

  @override
  State<MultipleExamScreen> createState() => _MultipleExamScreenState();
}

class _MultipleExamScreenState extends State<MultipleExamScreen>
    with TickerProviderStateMixin {
  int _currentPageIndex = 0;
  int _score = 0;

  List<dynamic> _quizData = [];
  // TextToSpeech tts = TextToSpeech();
  bool loaded = true;

  var countDown;
  Timer? timer;
  bool ispressed = false;

  // final player = AudioPlayer();
  // player.play(AssetSource('jsons/td_whistle.wav'));

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
  //       adUnitId: 'ca-app-pub-5562442825626470/4487310197',
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
        //     onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {});
      });

      // );
    } catch (e) {}
  }

  List selectedSubject = [];
  List firstQuestlist = [];
  List secondQuestlist = [];
  List thirdQuestlist = [];
  List fourthQuestlist = [];
  bool gottenAllData = true;

  // BannerAd? _bannerAd;
  // bool _isLoaded = false;
  // void loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: 'ca-app-pub-5562442825626470/8260455121',
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

  // https://questions.aloc.com.ng/api/v2/m?subject=${_selectedSubjects[3]}&year=${selectedYearnQuestion['examyear']}&type=${widget.examType}

//seles year https://questions.aloc.com.ng/api/v2/q/40?subject=${subjectName.toLowerCase()}
  startTimer() {
    // final player = AudioPlayer();
    // player.play(AssetSource('jsons/td_whistle.wav'));
    setState(() {
      countDown = 60;
      // start = true;
      // _isruning = true;
    });
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
                      url: '',
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
            title: Text(
                '${widget.firstsubject} study for ${widget.examType} is Completed'),
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

  getQuestionsData() async {
    var request = await http.get(
        Uri.parse(
            'https://questions.aloc.com.ng/api/v2/m?subject=${widget.firstsubject}&year=${widget.year}&type=${widget.examType}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
        }).then((value) async {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        setState(() {
          gottenAllData = false;
          _quizData = data['data'];
        });
        if (_quizData != [] || _quizData != null) {
          setState(() {
            gottenAllData = false;
          });
        }
        startTimer();
        print('First list $firstQuestlist');
      } else {
        var request = await http.get(
            Uri.parse(
                'https://questions.aloc.com.ng/api/v2/q/40?subject=${widget.firstsubject}'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
            }).then((value) {
          if (value.statusCode == 200) {
            var data = jsonDecode(value.body);
            setState(() {
              _quizData = data['data'];
            });
            if (_quizData != [] || _quizData != null) {
              setState(() {
                gottenAllData = false;
              });
            }
            startTimer();
            print('First list $_quizData');
          } else {
            var data = jsonDecode(value.body);
            print('First list $firstQuestlist');
          }
        });
      }
    });
  }

  late final TabController _tabController =
      TabController(length: 4, vsync: this);
  PageController _firstcontroller = PageController(initialPage: 0);
  PageController _secondcontroller = PageController(initialPage: 0);
  PageController _thirdcontroller = PageController(initialPage: 0);
  PageController _fourthcontroller = PageController(initialPage: 0);
  String tab1 = '';
  Color mainColor = Color.fromARGB(0, 255, 255, 255);
  Color second = Color(0xff);

  Color btnColor = Color(0xff);

  int score = 0;
  bool secondbol = true;
  bool thirdbol = true;
  bool fourth = true;
  getsecondQuestions() async {
    var request = await http.get(
        Uri.parse(
            'https://questions.aloc.com.ng/api/v2/m?subject=${widget.secondsubject}&year=${widget.year}&type=${widget.examType}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
        }).then((value) async {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        setState(() {
          secondQuestlist = data['data'];
        });
        if (secondQuestlist != [] || secondQuestlist != null) {
          setState(() {
            secondbol = false;
          });
        }
        startTimer();
        print(data['data']);
      } else {
        var request = await http.get(
            Uri.parse(
                'https://questions.aloc.com.ng/api/v2/q/40?subject=${widget.secondsubject}'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
            }).then((value) {
          if (value.statusCode == 200) {
            var data = jsonDecode(value.body);
            setState(() {
              secondQuestlist = data['data'];
            });
            if (secondQuestlist != []) {
              setState(() {
                secondbol = false;
              });
            }
            startTimer();
            print(data['data']);
          } else {
            var data = jsonDecode(value.body);
            print(data['data']);
          }
        });
      }
    });
  }

  getthirdQuestions() async {
    var request = await http.get(
        Uri.parse(
            'https://questions.aloc.com.ng/api/v2/m?subject=${widget.thirdsubject}&year=${widget.year}&type=${widget.examType}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
        }).then((value) async {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        setState(() {
          thirdQuestlist = data['data'];

          thirdbol = false;
        });
        startTimer();
        print(data['data']);
      } else {
        var request = await http.get(
            Uri.parse(
                'https://questions.aloc.com.ng/api/v2/q/40?subject=${widget.thirdsubject}'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
            }).then((value) {
          if (value.statusCode == 200) {
            var data = jsonDecode(value.body);
            setState(() {
              thirdQuestlist = data['data'];

              thirdbol = false;
            });
            startTimer();
            print(data['data']);
          } else {
            var data = jsonDecode(value.body);
            print(data['data']);
          }
        });
      }
    });
  }

  getfourthQuestions() async {
    var request = await http.get(
        Uri.parse(
            'https://questions.aloc.com.ng/api/v2/m?subject=${widget.fourthsubject}&year=${widget.year}&type=${widget.examType}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
        }).then((value) async {
      if (value.statusCode == 200) {
        var data = jsonDecode(value.body);
        setState(() {
          fourthQuestlist = data['data'];

          fourth = false;
        });
        startTimer();
        print(data['data']);
      } else {
        var request = await http.get(
            Uri.parse(
                'https://questions.aloc.com.ng/api/v2/q/40?subject=${widget.fourthsubject}'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
            }).then((value) {
          if (value.statusCode == 200) {
            var data = jsonDecode(value.body);
            setState(() {
              fourthQuestlist = data['data'];

              fourth = false;
            });
            startTimer();
            print(data['data']);
          } else {
            var data = jsonDecode(value.body);
            print(data['data']);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getQuestionsData();
    selectedSubject = widget.subjectsList;
    getsecondQuestions();
    getthirdQuestions();
    getfourthQuestions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _selectedAnser;
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '',
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
        title: const Text('Jamb Exams'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '${selectedSubject[0]}'),
            Tab(text: '${selectedSubject[1]}'),
            Tab(text: '${selectedSubject[2]}'),
            Tab(text: '${selectedSubject[3]}'),
          ],
        ),
      ),
      body: gottenAllData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _tabController, children: [
              Expanded(
                child: PageView.builder(
                    itemCount: _quizData.length,
                    controller: PageController(initialPage: _currentPageIndex),
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
                                    //=> tts.speak(
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
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${_quizData[index]['image']}'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20)),
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
                                        borderRadius: BorderRadius.circular(18),
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
                            )
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

              //second
            ]),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: gottenAllData
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               height: double.infinity,
//               width: double.infinity,
//               child: Expanded(
//                 child: Column(
//                   children: [
//                     //Tabs
//                     SizedBox(
//                       height: 50,
//                       child: TabBar(
//                           indicatorSize: TabBarIndicatorSize.label,
//                           indicatorColor: Color.fromARGB(255, 111, 235, 240),
//                           controller: _tabController,
//                           isScrollable: true,
//                           labelStyle: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                           labelColor: Color.fromARGB(255, 78, 187, 82),
//                           unselectedLabelColor: Colors.grey.withOpacity(0.3),
//                           tabs: [
//                             Tab(
//                               text: selectedSubject[0],
//                             ),
//                             Tab(
//                               text: selectedSubject[1],
//                             ),
//                             Tab(
//                               text: selectedSubject[2],
//                             ),
//                             Tab(
//                               text: selectedSubject[3],
//                             )
//                           ]),
//                     ),

//                     //TabBar View
//                     TabBarView(controller: _tabController, children: [
//                       // first tab
//                       Expanded(
//                         child: PageView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             controller: _firstcontroller,
//                             onPageChanged: (page) {
//                               setState(() {});
//                             },
//                             itemCount: firstQuestlist.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               );
//                             }),
//                       ),

//                       //second tab

//                       Expanded(
//                         child: PageView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             controller: _secondcontroller,
//                             onPageChanged: (page) {
//                               setState(() {});
//                             },
//                             itemCount: secondQuestlist.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               );
//                             }),
//                       ),

//                       //third tab

//                       Expanded(
//                         child: PageView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             controller: _thirdcontroller,
//                             onPageChanged: (page) {
//                               setState(() {});
//                             },
//                             itemCount: thirdQuestlist.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               );
//                             }),
//                       ),

//                       //fourth tab

//                       Expanded(
//                         child: PageView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             controller: _fourthcontroller,
//                             onPageChanged: (page) {
//                               setState(() {});
//                             },
//                             itemCount: fourthQuestlist.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                               );
//                             }),
//                       ),
//                     ]),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
