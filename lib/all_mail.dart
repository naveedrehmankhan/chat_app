import 'package:chat_app/Message_screen.dart';
import 'package:chat_app/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllMail extends StatefulWidget {
  const AllMail({Key? key}) : super(key: key);

  @override
  State<AllMail> createState() => _AllMailState();
}

class _AllMailState extends State<AllMail> {
  final Stream<QuerySnapshot> Messages =
      FirebaseFirestore.instance.collection('Messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
              // margin: EdgeInsets.only(left: 32),
              height: 700,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: Messages,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      return Container(
                        width: 400,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllMessage()));
                                }),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, right: 90),
                                  height: 50,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 213, 209, 209),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  right: 30),
                                              child: Text('${data['email']}',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              )),
        ],
      ),
    );
  }
}
