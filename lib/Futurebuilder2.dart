import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FutureBuilder2 extends StatefulWidget {
  @override
  _FutureBuilder2State createState() => _FutureBuilder2State();
}

class _FutureBuilder2State extends State<FutureBuilder2> {
  Future getdata() async {
    //final firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('DataStore').get();
    // ignore: deprecated_member_use
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green,
                    elevation: 5,
                    child: Column(
                      children: [
                        Text(snapshot.data[index]['Name']),
                        Text(snapshot.data[index]['Address']),
                        Text(snapshot.data[index]['Phone Number']),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
