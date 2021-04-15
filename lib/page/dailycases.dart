import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyCases extends StatefulWidget {
  @override
  _DailyCasesState createState() => _DailyCasesState();
}

class _DailyCasesState extends State<DailyCases> {
  CollectionReference dailys = FirebaseFirestore.instance
      .collection('Daily Cases'); //Call firestore which is 'Daily Cases'
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'State cases',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          //StreamBuilder
          stream: dailys.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot daily = snapshot.data.docs[index];
                  return ListTile(
                    leading:
                        Image.network(daily['img']), //Load image from firestore
                    title: Text(daily['title']), //Load title from firestore
                    subtitle:
                        Text(daily['detail']), //Load detail from firestore
                  );
                });
          },
        ));
  }
}
