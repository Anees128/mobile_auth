import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Adddata2 extends StatefulWidget {
  @override
  _Adddata2State createState() => _Adddata2State();
}

class _Adddata2State extends State<Adddata2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String password;
  @override
  Widget build(BuildContext context) {
    // MediaQuerry Define
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Center(
            child: Text(
          "AUTH FIREBASE",
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
              top: 30,
              left: 20,
              child: Form(
                key: _formkey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Add Data to Firebase',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "User Name is Required";
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
                              labelText: "User Name"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: MediaQuery.of(context).size.width * .80,
                        child: TextFormField(
                          // ignore: missing_return
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Password Required";
                            } else {
                              setState(() {
                                password = value.trim();
                              });
                            }
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              labelText: "Password"),
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
                                  _auth
                                      .createUserWithEmailAndPassword(
                                          email: name, password: password)
                                      .whenComplete(() {
                                    String user = _auth.currentUser.uid;
                                    FirebaseFirestore.instance
                                        .collection("user")
                                        .doc()
                                        .set({
                                      'name': name,
                                      'Phone': password,
                                      'UID': user
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Signup Done",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                                }
                              },
                              child: Text("Login"),
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
                  height: MediaQuery.of(context).size.height * .70,
                  width: MediaQuery.of(context).size.width * .90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
