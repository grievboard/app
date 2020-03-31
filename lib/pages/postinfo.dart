import 'package:flutter/material.dart';

class postInfo extends StatefulWidget{
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  final String gpoccontact;
  final String gpocname;
  final String name;
  final String status;
  final List consequences;
  final String description;

  postInfo({
    this.postId,
    this.postOwnerId,
    this.postMediaUrl,
    this.name,
    this.consequences,
    this.gpocname,
    this.gpoccontact,
    this.status,
    this.description
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return postInfoState();
  }

}

class postInfoState extends State<postInfo>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(child: Text(widget.name)) ,);
  }

}