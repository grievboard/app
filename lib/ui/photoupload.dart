//import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grievboard/ui/home.dart';
//import 'package:grievboard/utils/firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';


class PhotoUpload extends StatefulWidget {
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  //ProgressDialog pr;
  
  //var percentage =0.0;
  //ProgressDialog().update(message: "uploading");

  File sampleImage;
  String status = 'false';
  String _myValue;
  String url;
  final formkey = new GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave()
  {
    final form = formkey.currentState;

    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
  }
  void _uploadStatusImage() async 
  {
    ProgressDialog(context).update(message: "Posting...");
    ProgressDialog(context).show();
   
    if(validateAndSave())
    {
      
      //ProgressDialog(context).show();
      //ProgressDialog(context).show();
      
      final  StorageReference postImageRef = FirebaseStorage.instance.ref().child("post Images");

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() +".jpg").putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();

      print("image url =" + url);
     
      //DatabaseService();
      saveToFirestore(url);
      saveToDatabase(url);
      
      ProgressDialog(context).dismiss();
     // ProgressDialog(context).show(message: "Posting...");
     gotoHomepage();
     //HomePage();
     
    }
  }

  void saveToDatabase(url){

    var dbtimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbtimeKey);
    String time = formatTime.format(dbtimeKey);


    DatabaseReference ref = FirebaseDatabase.instance.reference();
    
    var details = 
    {
      "image" : url,
      "description": _myValue,
      "date": date,
      "time":time,
    };

    ref.child("Posts").push().set(details);
    
  }

  void saveToFirestore(url){

    var dbtimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbtimeKey);
    String time = formatTime.format(dbtimeKey);
    //String status ;


    Firestore.instance.collection("posts").add({
    //Future<Void> saveUser(FirebaseUser user) async {
       "image ": url,
      "description": _myValue,
      "date": date,
      "time": time,
      "status" : status,
      
    });
  }

  void gotoHomepage()
  {
    Navigator.pop(
    (
      context),
       MaterialPageRoute(builder: (context)
       {
         return HomePage();
       }
       )
    );
  }

  @override
  Widget build(BuildContext context) {
    //progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    return new Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: new Text("Upload image"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("select image") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),

      
    );
  }
  
  Widget enableUpload(){
    //progressDialog = ProgressDialog(context, ProgressDialogType.Normal);
    return  Container(

      child:  new Form(
        key:  formkey,

      child: Column(

        children: <Widget>[

          Image.file(sampleImage, height: 330.0, width:660.0),

          SizedBox(height: 15.0,),

          TextFormField(
            decoration: new InputDecoration(labelText: 'description'),
            validator: (value){
              return value.isEmpty ? ' description required' : null;
            },
            onSaved: (value){
             return _myValue =value;
            },

          ),
          SizedBox(height: 15.0,),
          
           RaisedButton(
            elevation: 10.0,
            child: Text("add a new post"),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: (){
               _uploadStatusImage();  
               
            }

               //uploadStatusImage,

            ),
          
        ],

      ),
      ),
    );
  }
}
