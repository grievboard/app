import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grievboard/ui/photoupload.dart';
 
import 'package:grievboard/utils/firebase_auth.dart';
//import 'package:progress_dialog/progress_dialog.dart';

import 'Posts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _count = 0;
 // ProgressDialog pr;
  List<Posts> postlist =  [];
@override
  void initState() {
    
    super.initState();
    DatabaseReference postsref = FirebaseDatabase.instance.reference().child("Posts");
    postsref.once().then((DataSnapshot snap)
        {
          var kys = snap.value.keys;
          var dta = snap.value;

          postlist.clear();

          for( var individualKey in kys){
            Posts posts = new Posts
            (
              dta[individualKey]['image'],
              dta[individualKey]['description'],
              dta[individualKey]['date'],
              dta[individualKey]['time'],

            );
            postlist.add(posts);

          }
          setState(() {
            print('Length : $postlist.length');
          });

        });
      }
    
      @override
      Widget build(BuildContext context){
        return new Scaffold(
          backgroundColor: Colors.white38,
          appBar: new AppBar(
            title: new Text('Home Page'),
            backgroundColor: Colors.orange,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.exit_to_app), onPressed: AuthProvider().logOut),
            ],
          ),
          body: new Container(
            
          
            child: postlist.length== 0 ? new LinearProgressIndicator() : new ListView.builder
            (
              itemCount: postlist.length,
              itemBuilder: (_, index)
              {
                return postsUI(postlist[index].image, postlist[index].description, postlist[index].date, postlist[index].time);
              }
              
            ),
            
            
            
          ),
          bottomNavigationBar: new BottomAppBar(
            color: Colors.green,
            child: new Container(
              margin: const EdgeInsets.only(left: 50.0, right: 50.0),
              child:  new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.person),
                    iconSize: 50,
                    color: Colors.white,
                     onPressed: () {
                       AuthProvider().logOut();
                     },
                  ),
                  new IconButton(
                    icon: new Icon(Icons.add_a_photo),
                    iconSize: 40,
                    color: Colors.white,
                     onPressed: () {
                       Navigator.push
                       (
                         context,
                         MaterialPageRoute(builder: (context)
                         {
                           return new PhotoUpload();
                         })
                         );
                     },
                  ),
                ],
              ),
            )
          ),
        );
      }


        Widget postsUI(String image, String description, String date, String time)
        {
          return new Card(
            elevation: 5.0,
            margin: EdgeInsets.all(8.0),
            child: new Container(
              padding: new EdgeInsets.all(14.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment .start,
                children: <Widget>
                [
                  new Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      new Text
                    (
                      date,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),
                    new Text
                    (
                      time,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                    )
                    ],
                  ),
                  SizedBox(height: 10.0,),
                   Image.network(image, fit: BoxFit.cover),
                  SizedBox(height: 10.0,),
                  new Row
                  (
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                     new IconButton(
                       alignment: Alignment.bottomLeft,
                       onPressed: (){},
                       icon: Icon(Icons.favorite_border, size: 35.0,color: Colors.blue,),
                     ),
                     new Text
                    (
                      description,
                      style: Theme.of(context).textTheme.subhead,
                      textAlign: TextAlign.right,
                    ),
                    ],
                  ),
                   
                ],

              ),

            ),

          );

        }
    }
    