import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Datastore2 extends StatefulWidget {
  @override
  _Datastore2State createState() => _Datastore2State();
}

class _Datastore2State extends State<Datastore2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String name;
  String fname;
  String phone;
  String adress;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Center(
            child: Text(
          "Auth Firesbase",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
            color: Colors.yellow[600],
          ),
        )),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.blue[900],
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: height / 3,
                width: width,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Form(
                key: _formkey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Add Data to Firebase',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 2, 2),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Enter Your Name";
                            } else {
                              setState(() {
                                name = value.trim();
                              });
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Name"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 2, 2),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Enter Father Name";
                            } else {
                              setState(() {
                                fname = value.trim();
                              });
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Father Name"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 2, 2),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          initialValue: '+92',
                          maxLength: 13,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Enter Phone Number";
                            } else {
                              setState(() {
                                phone = value.trim();
                              });
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Phone Number"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8, 1, 2, 2),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (value) {
                            setState(() {
                              adress = value.trim();
                            });
                          },
                          obscureText: false,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Address"),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              color: Colors.blueAccent[900],
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  final DateTime now = DateTime.now();
                                  // FirebaseFirestore.instance
                                  //     .collection("DataStore")
                                  //     .doc('$now')
                                  //     .set({
                                  //   'Name': name,
                                  //   'Father Name': fname,
                                  //   'Phone Number': phone,
                                  //   'Address': adress,
                                  //   'SaveTimings': now,
                                  FirebaseFirestore.instance
                                      .collection("CurrentUser")
                                      .doc("$now")
                                      .set({
                                    'First Name': name,
                                    'Last Name': fname,
                                    'phone Number': phone,
                                    'Time Save': now,
                                  });

                                  Fluttertoast.showToast(
                                      msg: "Signup Done",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Text("Save Form"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  RaisedButton(
                                    onPressed: () => {openurl(), {}},
                                    child: Text("Firebase Open"),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(180),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(180),
                      )),
                  height: MediaQuery.of(context).size.height * .80,
                  width: MediaQuery.of(context).size.width * .90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openurl() {
    String urll =
        "https://console.firebase.google.com/project/mobileauth-98f3e/firestore/data~2FDataStore~2FjfhBbiQpapdCnaDNsbmO";
    launch(urll);
  }
}
