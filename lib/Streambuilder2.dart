import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Streambuilder2 extends StatefulWidget {
  @override
  _Streambuilder2State createState() => _Streambuilder2State();
}

class _Streambuilder2State extends State<Streambuilder2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('DataStore').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.green[400],
                child: ListTile(
                  title: Center(
                      child: Column(
                    children: [
                      Text('Name= ${snapshot.data.docs[index]['Name']}'),
                      Text(
                          'Father Name =${snapshot.data.docs[index]['Father Name']}'),
                      Text('Address=${snapshot.data.docs[index]['Address']}'),
                      Text(
                          'Phone Number${snapshot.data.docs[index]['Phone Number']}'),
                    ],
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
