import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

import '../widgets/data_screen.dart';

class SwapMoney extends StatefulWidget {
  SwapMoney({super.key});
  // double money;
  @override
  State<SwapMoney> createState() => _SwapMoneyState();
}

class _SwapMoneyState extends State<SwapMoney> {
  TextEditingController _number = TextEditingController();
  TextEditingController _amount = TextEditingController();
  var selectedNetwork;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var name;
  bool getAll = true;
  List networkList = [
    "MTN",
    "Airtel",
    "Glo",
    "9Mobile",
  ];

  bool loading = false;
  var amount;
  String showMoney = '';

  getData() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          name = data["UserName"];
          amount = data["money"];
          showMoney = amount.toStringAsFixed(2);
          getAll = false;
        });
        print(amount);
        print(name);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  String superjaraToken = "Token 405b53bd1bb7f5fcbd818f97ca6461985ecdfff8";
  int networkId = 0;

  var selectedDataPlan;
  var selectedPlanID;
  List dataplanList = [];
  var selecteddDataplan;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _number.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.server,
                  ),
                ),
                Tab(
                  icon: FaIcon(
                    FontAwesomeIcons.internetExplorer,
                  ),
                ),
              ],
            ),
            title: Text('Select Between Airtime and Data'),
          ),
          body: TabBarView(children: [
            //Airtime Container
            getAll
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      )
                    ],
                  )
                : Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Available Balance',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: '\₦',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[100],
                                            fontSize: 20),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: amount == null
                                                  ? 'No Balance'
                                                  : '$showMoney',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 40)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //Network dropdown will be here

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
                                    'Select Network',
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
                            items: networkList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedNetwork,
                            onChanged: (value) {
                              setState(() {
                                selectedNetwork = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 160,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
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
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
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
                                  color: Color.fromARGB(255, 216, 215, 215)
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              // maxLength: 4,
                              decoration: InputDecoration(
                                icon: FaIcon(
                                  FontAwesomeIcons.listNumeric,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                hintText: 'Enter Amount',
                                border: InputBorder.none,
                              ),
                              controller: _amount,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
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
                                  color: Color.fromARGB(255, 216, 215, 215)
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextField(
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              // maxLength: 11,
                              decoration: InputDecoration(
                                icon: FaIcon(
                                  FontAwesomeIcons.phone,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                hintText: 'Enter Phone Number',
                                border: InputBorder.none,
                              ),
                              controller: _number,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        GestureDetector(
                          onTap: () async {
                            if (_amount.text == '' || _number.text == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please Provide details"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (int.parse(_amount.text) > amount) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Low Balace"),
                                backgroundColor: Colors.red,
                              ));
                            } else if (_number.text.length < 11 ||
                                int.parse(_amount.text) < 50) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Please check provided Details"),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              //purchase Airtime
                              String input = _number.text;
                              var network = selectedNetwork.toLowerCase();

                              int charge = int.parse(_amount.text.trim());
                              setState(() {
                                loading = true;
                                // input = _number.text;
                              });

                              if (network == 'mtn') {
                                setState(() {
                                  networkId = 1;
                                });
                              } else if (network == 'glo') {
                                setState(() {
                                  networkId = 2;
                                });
                              } else if (network == '9mobile') {
                                setState(() {
                                  networkId = 3;
                                });
                              } else if (network == 'airtel') {
                                setState(() {
                                  networkId = 4;
                                });
                              }

                              Uri url = Uri.parse(
                                  'https://www.superjara.com/api/topup/');
                              var res = await http.post(url,
                                  headers: {
                                    'Authorization': superjaraToken,
                                    'Content-Type': 'application/json'
                                  },
                                  body: json.encode({
                                    "network": networkId,
                                    "amount": charge,
                                    "mobile_number": input,
                                    "Ported_number": true,
                                    "airtime_type": "VTU"
                                  }));
                              var data = json.decode(res.body);
                              if (res.statusCode == 'invalid_username') {
                                print(networkId);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Something went wrong \n The Error message is ${data['message']}"),
                                  backgroundColor: Colors.red,
                                ));
                                print(
                                    'The Error message is ${data['message']}');
                                setState(() {
                                  loading = false;
                                });
                              } else if (res.statusCode == 200 ||
                                  res.statusCode == 201) {
                                var vak = amount - double.parse(_amount.text);
                                // setState(() {
                                //   var vak = amount - double.parse(_amount.text);
                                // });
                                db
                                    .collection('UsersDetails')
                                    .doc(firebaseAuth.currentUser!.uid)
                                    .update({
                                  "money": vak,
                                });
                                setState(() {
                                  loading = false;
                                });
                                print(networkId);
                                getData();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Purchased"),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Something  went wrong"),
                                  backgroundColor: Colors.green,
                                ));
                              }
                            }
                          },
                          child: loading
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
                                      'Purchase Airtime',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),

            //Data container
            Datascreen()
          ]),
        ));
  }
}
