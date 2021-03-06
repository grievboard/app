//cdimport 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:grievboard/pages/home.dart';
import 'package:grievboard/pages/splash_screen.dart';
//import './pages/home.dart';

void main() {
  // Firestore.instance.settings(timestampsInSnapshotsEnabled: true).then((_) {
  //   // print("Timestamps enabled in snapshots\n");
  // }, onError: (_) {
  //   // print("Error enabling timestamps in snapshots\n");
  // });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrievBoard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      home: SplashScreen(),
      //SplashScreen(),
    );
  }
}
