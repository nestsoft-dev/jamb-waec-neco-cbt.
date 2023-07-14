import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import 'navigation/navigation.dart';

class Results extends StatefulWidget {
  Results({required this.url, super.key});
  String url;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  //ads
 // RewardedAd? _rewardedAd;

  // TODO: replace this test ad unit with your own ad unit.

  /// Loads a rewarded ad.
  // void loadAd() {
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-5562442825626470/4487310197',
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         // Called when an ad is successfully received.
  //         onAdLoaded: (ad) {
  //           Future.delayed(Duration(seconds: 25)).then((value) {
  //             _rewardedAd!.show(onUserEarnedReward:
  //                 (AdWithoutView ad, RewardItem rewardItem) {
  //               //TODO add points
  //               // Reward the user for watching an ad.
  //             });
  //           });

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

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  bool getData = true;

  List allresults = [];

  getExamQuestions() async {
    print('url is ${widget.url}');
    var questions = await http.get(Uri.parse('${widget.url}'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'AccessToken': 'ALOC-02fa26c8c13b0c3e02e3'
    }).then((value) {
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        setState(() {
          allresults = data['data'];

          getData = false;
        });

        print(data['data']);
        callback();
      } else {
        print(data.toString());
        print('something went wrong Question');
      }
    });
  }

  var totalpoints;
  var amountWon;

  void callback() {
    getUserDetails() async {
      final docRef = await db
          .collection("UsersDetails")
          .doc(firebaseAuth.currentUser!.uid);
      try {
        docRef.get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            setState(() {
              totalpoints = data["points"];
              amountWon = data['money'];
              // getData = false;
              upload();
            });
            // print("Name: $name, balance is $points");

            // ...
          },
          onError: (e) => print("Error getting document: $e"),
        );
      } catch (e) {}
    }
  }

  upload() {
    var newPoints = totalpoints + allresults.length / 10 * 10;
    var newMoney = amountWon + allresults.length * 0.02;
    db.collection("UsersDetails").doc(firebaseAuth.currentUser!.uid).update({
      'points': newPoints,
      'money': newMoney,
    });
  }

  @override
  void initState() {
    super.initState();
    //loadAd();

    getExamQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 255, 217),
      body:
          //  getData
          // ? Center(
          //     child: CircularProgressIndicator(),
          //   )
          // :
          Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: []),
      ),
    );
  }
}
