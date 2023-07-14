import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class ExamsPins extends StatefulWidget {
  const ExamsPins({super.key});

  @override
  State<ExamsPins> createState() => _ExamsPinsState();
}

class _ExamsPinsState extends State<ExamsPins> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Purchase Exams Pins",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 61, 31)),
          )),
      body: Center(child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_ukkmrz6p.json',
            height: 250),),
      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 20, right: 20),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: 60,
      //         ),
      //         Text(
      //           'Please Select the Exam type',
      //           textAlign: TextAlign.start,
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           height: 60,
      //           width: MediaQuery.of(context).size.width,
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20),
      //             color: Colors.grey[200],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Text(
      //           'Please pin Quantity',
      //           textAlign: TextAlign.start,
      //         ),
      //         SizedBox(
      //           height: 5,
      //         ),
      //         Container(
      //           height: 60,
      //           width: MediaQuery.of(context).size.width,
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20),
      //             color: Colors.grey[200],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Text(
      //           'Your Email address',
      //           textAlign: TextAlign.start,
      //         ),
      //         SizedBox(
      //           height: 5,
      //         ),
      //         Container(
      //           height: 60,
      //           width: MediaQuery.of(context).size.width,
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           padding: EdgeInsets.all(8),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(20),
      //             color: Colors.grey[200],
      //           ),
      //           child: Row(
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.addressBook,
      //               ),
      //               SizedBox(
      //                 width: 15,
      //               ),
      //               Expanded(
      //                 child: Text(
      //                   'Netsoftdevelopers@gmail.com',
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             print('purchase pin');
      //           },
      //           child: Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: 60,
      //             margin: EdgeInsets.symmetric(horizontal: 30),
      //             decoration: BoxDecoration(
      //               color: Colors.green,
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             child: Center(
      //               child: Text(
      //                 'Purchase Exam pin',
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 22),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
