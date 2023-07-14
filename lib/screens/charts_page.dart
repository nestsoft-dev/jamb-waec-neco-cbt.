import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var data;

  getAlllist() async {
    db.collection("UsersDetails").get().then(
      (querySnapshot) {
        data = querySnapshot.docs;
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    super.initState();
    getAlllist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Top Points Holder",
            style: TextStyle(color: Color.fromARGB(255, 0, 61, 31)),
          )),
      body: StreamBuilder(
          stream: db.collection("UsersDetails").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.only(top: 2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    '${index + 1}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${doc['UserName']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('${doc['Email']}'),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              'Total Points ${doc['points']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 61, 31)),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_a2chheio.json',
                    height: 250),
              );
            }
          }),
    );
  }
}
