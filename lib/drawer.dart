import 'package:chat_app/all_mail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final Stream<QuerySnapshot> Messages =
      FirebaseFirestore.instance.collection('Messages').snapshots();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.amber,
        child: Column(
          children: [
            Container(
              width: 150,
              margin: EdgeInsets.only(top: 300),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllMail()));
                  },
                  child: Row(
                    children: [
                      Text('All Mail'),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.mail_lock_outlined)
                    ],
                  )),
            )
          ],
        ));
  }
}
