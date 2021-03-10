import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_auth/Futurebuilder2.dart';
import 'Adddata.dart';
import 'Adddata2.dart';
import 'Datastore2.dart';
import 'Streambuilder2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton(
                child: Text('Auth First'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Adddata()));
                }),
          ),
          Center(
              child: RaisedButton(
                  child: Text('Auth Second'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Adddata2()));
                  })),
          Center(
              child: RaisedButton(
                  child: Text('add data into firestore'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Datastore2()));
                  })),
          Center(
              child: RaisedButton(
                  child: Text(
                    'Fetch data using Future Builder',
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilder2()));
                  })),
          Center(
              child: RaisedButton(
                  child: Text(
                    'Fetch data using Stream Builder',
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Streambuilder2()));
                  })),
        ],
      ),
    );
  }
}
