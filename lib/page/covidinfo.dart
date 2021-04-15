import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference infoGraphic = FirebaseFirestore.instance
        .collection('Infographic'); //Call firestore which is 'Infographic
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Infographic',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: infoGraphic.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              const Text('Loading');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snapshot.data.docs[index];
                    return Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 415.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Material(
                              color: Color(0xffFFFAFA),
                              elevation: 14.0,
                              shadowColor: Color(0xffFF7F50),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 350.0,
                                        child: Image.network(
                                            '${mypost['image']}', //Load image from firestore
                                            fit: BoxFit.fill),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        '${mypost['title']}', //Load title form firestore
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ));
  }
}
