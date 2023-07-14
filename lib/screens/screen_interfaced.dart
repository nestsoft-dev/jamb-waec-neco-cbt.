import 'dart:convert';

import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';

import '../widgets/chat_gpt_multi.dart';
import 'multiples_exam_screen.dart';

class Interface extends StatefulWidget {
  Interface({required this.examType, super.key});

  @override
  State<Interface> createState() => _InterfaceState();
  String examType;
}

class _InterfaceState extends State<Interface> {
  var selectedYearnQuestion;
  bool datagotten = false;

  String selectedUtmeExamType = '';
  var listQuestionsnYear = [
    {'examyear': '2003', 'questions': 40},
    {'examyear': '2004', 'questions': 40},
    {'examyear': '2005', 'questions': 40},
    {'examyear': '2006', 'questions': 40},
    {'examyear': '2007', 'questions': 40},
    {'examyear': '2008', 'questions': 40},
    {'examyear': '2009', 'questions': 40},
    {'examyear': '2010', 'questions': 40},
    {'examyear': '2011', 'questions': 40},
    {'examyear': '2012', 'questions': 40},
    {'examyear': '2013', 'questions': 40},
    {'examyear': '2014', 'questions': 40},
    {'examyear': '2015', 'questions': 40},
    {'examyear': '2016', 'questions': 40},
    {'examyear': '2017', 'questions': 40},
    {'examyear': '2018', 'questions': 40},
    {'examyear': '2019', 'questions': 40},
    {'examyear': '2020', 'questions': 40},
    {'examyear': '2021', 'questions': 40},
    {'examyear': '2022', 'questions': 40},
    {'examyear': '2023', 'questions': 40},
    {'examyear': '2024', 'questions': 40},
  ];
  bool loadmu = true;
  // BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadAdR();
    // loadAdBanner();
  }

  var images = [
    'assets/neco_icon.jpg',
    'assets/waec_icon.png',
    'assets/jamb_icon.jpeg',
  ];

  // void loadAdBanner() {
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

  // RewardedAd? _rewardedAd;
  // void loadAdR() {
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-7278030962540782/1996159984',
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (ad) {
  //           _rewardedAd!
  //               .show(onUserEarnedReward: (AdWithoutView, RewardItem) {});
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

  int? selectedTime;
  List<int> timeoptions = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
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
      'subject': 'Englishlit ',
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

  final List<String> _allSubjects = [
    'History',
    'English',
    'Mathematics',
    'Commerce',
    'Accounting',
    'Biology',
    'Physics',
    'Chemistry',
    'Englishlit',
    'Government',
    'CRK',
    'Geography',
    'Economics',
    'IRK',
    'Civiledu',
    'Currentaffairs',
    'Insurance',
  ];

  List<String> _selectedSubjects = [];

  void _onChipSelected(String subject) {
    setState(() {
      if (_selectedSubjects.contains(subject)) {
        _selectedSubjects.remove(subject);
      } else if (_selectedSubjects.length < 4) {
        _selectedSubjects.add(subject);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Available Subjects',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: courses.length,
                  scrollDirection: axisDirectionToAxis(AxisDirection.right),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage('${courses[index]['image']}'),
                            fit: BoxFit.cover),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Time Available for all Subjects is 2hours',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          // if (_bannerAd != null)
          //   SizedBox(
          //     width: _bannerAd!.size.width.toDouble(),
          //     height: _bannerAd!.size.height.toDouble(),
          //     child: AdWidget(ad: _bannerAd!),
          //   )
          // else
            SizedBox(),

          // ChipsChoice<int>.single(
          //   value: selectedTime,
          //   onChanged: (val) {
          //     setState(() {
          //       selectedTime = val;
          //       print(val);
          //     });
          //   },
          //   choiceItems: C2Choice.listFrom<int, int>(
          //     source: timeoptions,
          //     value: (i, v) => i,
          //     label: (i, v) => '$v',
          //   ),
          // ),

          Text(
            'Select up to 4 Subject:',
            style: TextStyle(fontSize: 18),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: _allSubjects.map((subject) {
                return ChoiceChip(
                  label: Text(subject),
                  selected: _selectedSubjects.contains(subject),
                  onSelected: (bool selected) {
                    _onChipSelected(subject);
                  },
                );
              }).toList(),
            ),
          ),

          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Year',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: listQuestionsnYear
                  .map(
                    (item) => DropdownMenuItem<dynamic>(
                      value: item,
                      child: Text(
                        "${item['examyear']} has ${item['questions']} Questions for each subject",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              value: selectedYearnQuestion,
              disabledHint: Text('Select Year'),
              onChanged: (value) {
                setState(() {
                  selectedYearnQuestion = value;
                });
              },
              buttonStyleData: ButtonStyleData(
                height: 50,
                width: 250,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.green,
                ),
                elevation: 2,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                width: 250,
                padding: null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.green,
                ),
                elevation: 8,
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all<double>(6),
                  thumbVisibility: MaterialStateProperty.all<bool>(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          GestureDetector(
            onTap: () {
              // if (selectedTime == null) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text('Please select time'),
              //     backgroundColor: Colors.red,
              //   ));
              // } else {
              // MultipleExamScreen

              // int numbers = selectedYearnQuestion['questions'];
              // print(numbers.runtimeType);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return QuizHomePage(
                  subjectsList: _selectedSubjects,
                  examType: '${widget.examType}',
                  year: '${selectedYearnQuestion['examyear']}',
                  firstsubject: '${_selectedSubjects[0]}',
                  fourthsubject: '${_selectedSubjects[3]}',
                  secondsubject: '${_selectedSubjects[1]}',
                  thirdsubject: '${_selectedSubjects[2]}',
                );
                // MultipleExamScreen(
                // subjectsList: _selectedSubjects,
                // examType: '${widget.examType}',
                // year: '${selectedYearnQuestion['examyear']}',
                // firstsubject: '${_selectedSubjects[0]}',
                // fourthsubject: '${_selectedSubjects[3]}',
                // secondsubject: '${_selectedSubjects[1]}',
                // thirdsubject: '${_selectedSubjects[2]}',
                // );
              }));
              // }
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'Start Exam',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]),
      ),

      //
    );
  }
}

           

//             SizedBox(
//               height: 10,
//             ),
//             //get exams year
         
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 'Please Note that all practice performance on $selectedUtmeExamType for ${widget.examType} for the year with be mailed to the guardian mail provided.',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Lottie.network(
//                 'https://assets1.lottiefiles.com/packages/lf20_h4th9ofg.json',
//                 height: 250),
//           ],
//         ),
//       ),
//     ),
//   ),
// ),
