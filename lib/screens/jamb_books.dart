import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class JambBooks extends StatefulWidget {
  const JambBooks({super.key});

  @override
  State<JambBooks> createState() => _JambBooksState();
}

class _JambBooksState extends State<JambBooks> {
  final CollectionReference books =
      FirebaseFirestore.instance.collection("JambBooks");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Jamb Books'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: books.get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No Jamb Novels Currently Available"),
                );
              } else {
                final data = snapshot.data!.docs;
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, right: 3, left: 3),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.6,
                      children: List.generate(data.length, (index) {
                        final image = data[index];
                        return GestureDetector(
                          onTap: () {
                            // print(image['books']);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (contex) {
                            //   return ViewPDF(bookurl: '${image['books']}',);
                            // }));
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image.get("booksImage"))),
                            ),
                            child: Center(
                                child: image.get("price") == ""
                                    ? Text("")
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Text("\₦${image.get("price")}"),
                                      )),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
