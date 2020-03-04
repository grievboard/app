import 'package:flutter/material.dart';
import './upload.dart';
import '../models/user.dart';

class NewPost extends StatefulWidget{
  final User currentUser;
  NewPost({this.currentUser});
  @override
  State<StatefulWidget> createState() {

    return NewPostState();
  }

}

class NewPostState extends State<NewPost>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(child: OutlineButton(onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Upload(currentUser: widget.currentUser);
      }));
    }),),);
  }

}