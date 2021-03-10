import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Adddata extends StatefulWidget {
  @override
  _AdddataState createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  final _data = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _formkey = GlobalKey<FormState>();
  String name;
  String phone;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        height: height,
        width: width,
        child: Form(
          key: _formkey,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: width,
                  height: height / 2.4,
                  child: Center(
                    child: Text(
                      'Add Data To FireStore',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                ),
              ),
              Positioned(
                top: 170,
                left: 10,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    height: height * .68,
                    width: width * .95,
                    alignment: Alignment.center,
                    child: ListView(
                      children: [
                        Container(
                          height: height * .50,
                          width: width * .95,
                          decoration: BoxDecoration(
                            //color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                width: width * .80,
                                child: TextFormField(
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Name is Required';
                                    } else {
                                      setState(() {
                                        return name = value.trim();
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.pinkAccent,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Name",
                                      hintText: "Enter Name Here"),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: width * .80,
                                child: TextFormField(
                                  // ignore: missing_return
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return 'Phone Number is Required';
                                    } else {
                                      setState(() {
                                        return phone = value.trim();
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.pinkAccent,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      labelText: "Phone",
                                      hintText: "Enter Phone Number here"),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_formkey.currentState.validate())
                                          try {
                                            _auth
                                                .createUserWithEmailAndPassword(
                                                    email: name,
                                                    password: phone)
                                                .whenComplete(() {
                                              _data
                                                  .collection("user")
                                                  .doc()
                                                  .set({
                                                'name': name,
                                                'Phone': phone
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Signup Done",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            });

                                            // print(phone);
                                          } catch (e) {
                                            Fluttertoast.showToast(
                                                msg: "Not Done",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                      },
                                      color: Colors.pinkAccent,
                                      child: Text(
                                        'SAVE DATA',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
