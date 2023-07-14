import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Datascreen extends StatefulWidget {
  const Datascreen({super.key});

  @override
  State<Datascreen> createState() => _DatascreenState();
}

class _DatascreenState extends State<Datascreen> {
  List<Map<String, dynamic>> countries = [];
  var selectedNetwork;
  var selectedDataPlan;
  var selectedPlanID;
  String superjaraToken = "Token 405b53bd1bb7f5fcbd818f97ca6461985ecdfff8";
  List networkList = [
    "MTN",
    "Airtel",
    "Glo",
    "9Mobile",
  ];

  TextEditingController _number = TextEditingController();
  var amount;
  var balance;
  var name;

  bool loading = false;
  bool loadmu = true;

  List dataplanList = [];
  var selecteddDataplan;

  Future<void> _getmtnplan() async {
    setState(() {
      dataplanList = [];
      loadmu = false;
      dataplanList = [
        {
          "plan_id": 285,
          "amount": 70,
          'size': '250.0 MB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 49,
          "amount": 120,
          'size': '500.0 MB',
          'validity': '30 days{Gifting}',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 208,
          "amount": 235,
          'size': '1GB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 209,
          "amount": 470,
          'size': '2.0 GB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 210,
          "amount": 705,
          'size': '3GB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 211,
          "amount": 1175,
          'size': '5.0 GB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 224,
          "amount": 17250,
          'size': '75.0 GB',
          'validity': 'A month',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 234,
          "amount": 225,
          'size': '1.0 GB',
          'validity': 'A month',
          'plantype': 'SME'
        },
        {
          "plan_id": 235,
          "amount": 450,
          'size': '2.0 GB',
          'validity': 'A month',
          'plantype': 'SME'
        },
        {
          "plan_id": 237,
          "amount": 450,
          'size': '2.0 GB',
          'validity': 'A month',
          'plantype': 'SME'
        },
        {
          "plan_id": 263,
          "amount": 675,
          'size': '3.0 GB',
          'validity': 'A month',
          'plantype': 'SME'
        },
        {
          "plan_id": 235,
          "amount": 1125,
          'size': '5.0 GB',
          'validity': 'A month',
          'plantype': 'SME'
        },
      ];

      // dataplanList = data['products'];
    });
    //   });
    // } catch (e) {}
  }

  Future<void> _getgloplan() async {
    // try {
    //   Uri url = Uri.parse(
    //       "https://mobileairtimeng.com/httpapi/get-items?userid=08169772123&pass=955a7cce704a7f766b42&service=glo");
    //   await http.get(url).then((response) {
    //     var data = json.decode(response.body);
    setState(() {
      dataplanList = [];
      loadmu = false;
      dataplanList = [
        {
          "plan_id": 291,
          "amount": 120,
          'size': '500MB',
          'validity': '30 days{Gifting}',
          'plantype': 'CORPORATE GIFTING'
        },
        {
          "plan_id": 292,
          "amount": 240,
          'size': '	1.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': '	CORPORATE GIFTING'
        },
        {
          "plan_id": 293,
          "amount": 480,
          'size': '2.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 294,
          "amount": 720,
          'size': '3.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': '	CORPORATE GIFTING'
        },
        {
          "plan_id": 295,
          "amount": 1200,
          'size': '5.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
      ];
    });
    //   });
    // } catch (e) {}
  }

  @override
  void dispose() {
    _number.dispose();

    super.dispose();
  }

  Future<void> _getairtelplan() async {
    // try {
    //   Uri url = Uri.parse(
    //       "https://mobileairtimeng.com/httpapi/get-items?userid=08169772123&pass=955a7cce704a7f766b42&service=airtel");
    //   await http.get(url).then((response) {
    //     var data = json.decode(response.body);
    setState(() {
      dataplanList = [];

      loadmu = false;
      dataplanList = [
        {
          "plan_id": 253,
          "amount": 130,
          'size': '500MB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 254,
          "amount": 250,
          'size': '1.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 255,
          "amount": 500,
          'size': '	2.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 279,
          "amount": 1200,
          'size': '5.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 280,
          "amount": 2600,
          'size': '10.0 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
      ];
    });
    //   });
    // } catch (e) {}
  }

  Future<void> _getNinemobileplan() async {
    // try {
    //   Uri url = Uri.parse(
    //       "https://mobileairtimeng.com/httpapi/get-items?userid=08169772123&pass=955a7cce704a7f766b42&service=9mobile");
    //   await http.get(url).then((response) {
    //     var data = json.decode(response.body);
    setState(() {
      dataplanList = [];
      loadmu = false;
      dataplanList = [
        {
          "plan_id": 182,
          "amount": 450,
          'size': '500MB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 183,
          "amount": 900,
          'size': '1.5 GB',
          'validity': '30 days',
          'plantype': ''
        },
        {
          "plan_id": 184,
          "amount": 1080,
          'size': '2.0 GB',
          'validity': '30 days',
          'plantype': ''
        },
        {
          "plan_id": 185,
          "amount": 1350,
          'size': '3.0 GB',
          'validity': '30 days',
          'plantype': ''
        },
        {
          "plan_id": 186,
          "amount": 1800,
          'size': '	4.5 GB',
          'validity': '30 days{Gifting}',
          'plantype': ''
        },
        {
          "plan_id": 187,
          "amount": 3600,
          'size': '	11.0 GB',
          'validity': '30 days',
          'plantype': ''
        },
      ];
    });
    //   });
    // } catch (e) {}
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  String showMoney = '';
  bool allready = true;
  Future<void> getData() async {
    final docRef =
        await db.collection("UsersDetails").doc(firebaseAuth.currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          name = data["UserName"];
          balance = data["money"];
          // if(balance != null || balance != ''){
          //   print(balance);
          // }
          allready = false;
        });

        print("Data screen Name: $name, balance is $balance");

        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int networkid = 0;
  var amountORproduct;

  void valuedchanged(_value) {
    if (_value == "MTN") {
      bool loadmu = true;
      networkid = 1;

      populateMTN();
    } else if (_value == "Airtel") {
      networkid = 4;

      bool loadmu = true;
      populateAirtel();
    } else if (_value == "GLO") {
      networkid = 2;

      bool loadmu = true;
      populateglo();
    } else if (_value == "9Mobile") {
      networkid = 3;

      bool loadmu = true;
      populate9mobile();
    }
    setState(() {
      selectedNetwork = _value;
    });
  }

  void populateMTN() {
    _getmtnplan();
  }

  void populateAirtel() {
    _getairtelplan();
    // _getairtelplan();
  }

  void populateglo() {
    _getgloplan();
  }

  void populate9mobile() {
    _getNinemobileplan();
  }

  double cent = 0.0;
  void secondvalueChanged(value) {}

  double percent = 0;
  bool bypass = false;
  void errorAlert() {}

  purchaseDatasuperjara(networkid, planID, phoneNumber, int planamount) async {
    print('network id is ${networkid}');
    print('plan id is ${planID.runtimeType}');
    print(' phone number is ${phoneNumber.runtimeType}');

    cent = 10 / 100 * planamount;
    percent = cent + planamount;

    try {
      var req = await http.post(
          Uri.parse('https://www.superjara.com/api/data/'),
          body: json.encode({
            "network": networkid,
            "mobile_number": "${_number.text}",
            "Ported_number": bypass,
            "plan": planID
          }),
          headers: {
            'Authorization': superjaraToken,
            'Content-Type': 'application/json'
          }).then((respons) {
        setState(() {
          loading = false;
        });
        var data = json.decode(respons.body);
        if (respons.statusCode == 200 || respons.statusCode == 201) {
          setState(() {
            var vak = balance - percent;
            db
                .collection("UsersDetails")
                .doc(firebaseAuth.currentUser?.uid)
                .update({"money": vak}).then((res) async {
              getData();

              // addData();
              print(vak.toString());
              setState(() {
                loadmu = false;
                loading = false;
              });
            });
          });
          Navigator.pop(context);
        } else {
          errorAlert();
          //failed to purchase
        }
        print(data);
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loadmu = false;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: allready
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),

                  //show Balance Card
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
                                            : '$balance',
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

                  //spinner1
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
                      onChanged: (_value) => valuedchanged(_value),
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
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
                    height: 15,
                  ),

                  //spinner2

                  loadmu
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                      : DropdownButtonHideUnderline(
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
                                    'Select Data plan',
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
                            items: dataplanList
                                .map((item) => DropdownMenuItem<dynamic>(
                                      value: item,
                                      child: Text(
                                        '${item["validity"]} for \₦${10 / 100 * item["amount"] + item["amount"]} Datasize ${item['size']}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedDataPlan,
                            disabledHint: Text('Select Network'),
                            onChanged: (value) {
                              setState(() {
                                selectedDataPlan = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 280,
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
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 280,
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
                            offset: Offset(0, 3), // changes position of shadow
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

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      getData();
                    }, child: Text('Refresh'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RadioListTile<bool>(
                    toggleable: true,
                    activeColor: Colors.green,
                    title: const Text('ByPass Validator'),
                    value: true,
                    groupValue: bypass,
                    onChanged: (value) {
                      setState(() {
                        bypass = !bypass;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //button
                  GestureDetector(
                    onTap: () async {
                      if (_number.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Provide a Phone Number"),
                          backgroundColor: Colors.red,
                        ));
                        // ScaffoldMessenger(child: Sc,)
                      } else if (_number.text.length < 11) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Please Provide a complete Phone Number"),
                          backgroundColor: Colors.red,
                        ));
                      } else if (selectedDataPlan["amount"] > balance) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Low Balance"),
                          backgroundColor: Colors.red,
                        ));
                        // purchaseData(selectedNetwork, phoneNumber, planAmount);
                      } else {
                        //mtn

                        setState(() {
                          loading = true;
                        });

                        String phoneNumber = _number.text;
                        int planID = selectedDataPlan["plan_id"];
                        int planamount = selectedDataPlan["amount"];

                        purchaseDatasuperjara(
                            networkid, planID, phoneNumber, planamount);
                      }
                    },
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurple),
                          )
                        : Container(
                            height: 60,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                'Buy Plan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
