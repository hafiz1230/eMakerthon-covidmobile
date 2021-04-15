import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clusters extends StatefulWidget {
  @override
  _ClustersState createState() => _ClustersState();
}

class _ClustersState extends State<Clusters> {
  CollectionReference clusterss = FirebaseFirestore.instance
      .collection('Cluster'); //Call firestore which is 'Cluster'
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cluster in Malaysia',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: clusterss.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot cluster = snapshot.data.docs[index];
                  return ListTile(
                    leading:
                        Text(cluster['header']), //Call 'header' from firestore
                    title: Text(cluster['title']), //Call 'title' from firestore
                    subtitle:
                        Text(cluster['detail']), //Call 'detail' from firestore
                  );
                });
          },
        ));
  }
}
