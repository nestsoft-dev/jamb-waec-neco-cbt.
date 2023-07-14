import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../charts_page.dart';
import '../exam_pins__purchase.dart';
import '../home_page.dart';
import '../jamb_books.dart';
import '../profile.dart';

class NavigationsPage extends StatefulWidget {
  const NavigationsPage({super.key});

  @override
  State<NavigationsPage> createState() => _NavigationsPageState();
}

class _NavigationsPageState extends State<NavigationsPage> {
  List screens = [HomePage(), Charts(), JambBooks(), ExamsPins(), MyProfile()];
  var currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 0, 145, 0),
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: FaIcon(
                FontAwesomeIcons.home,
              )),
          BottomNavigationBarItem(
              label: 'LearderBoard',
              icon: FaIcon(
                FontAwesomeIcons.chartBar,
              )),
          BottomNavigationBarItem(
              label: 'Books',
              icon: FaIcon(
                FontAwesomeIcons.book,
              )),
          BottomNavigationBarItem(
              label: 'Exam pins',
              icon: FaIcon(
                FontAwesomeIcons.sortNumericAsc,
              )),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: FaIcon(
                FontAwesomeIcons.user,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var whatsapp = "+2349138473122";
          var whatsappAndroid = Uri.parse(
              "whatsapp://send?phone=$whatsapp&text=Hello i need help from jambite");
          // if (await canLaunchUrl(whatsappAndroid)) {
          //   await launchUrl(whatsappAndroid);
          // } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("WhatsApp is not installed on the device"),
                backgroundColor: Colors.red,
              ),
            );
          //}
        },
        child: Icon(Icons.support_agent),
        backgroundColor: Color.fromARGB(255, 0, 61, 31),
      ),
    );
  }
}
