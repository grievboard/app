import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import './home.dart';
import './search.dart';
import '../widgets/header.dart';
import '../widgets/post.dart';
import '../widgets/progress.dart';
import 'package:avatar_glow/avatar_glow.dart';
import './upload.dart';
import './newpost.dart';
import './postpages/page1.dart';
import '../utils/transitionz.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User currentUser;

  Timeline({this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  //
  double top, bottom, left = 0, right;
  double scale = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var newsListSliver;
  List<Post> posts;
  List<String> followingList = [];
  ScrollController _controller;

  _scrollListener() {
    //896

    if ((_controller.offset < (MediaQuery.of(context).size.height) * 0.1699)) {
      scale = 1 - (_controller.offset * 2) / 1000;
      setState(() {
        top = -45.0 +
            _controller.offset * 2 +
            (MediaQuery.of(context).size.height) / 2;
        if (left + _controller.offset < MediaQuery.of(context).size.width) {
          left = -67.0 +
              _controller.offset +
              MediaQuery.of(context).size.width / 2;
        }
      });
    }
    print(_controller.offset);
    print(MediaQuery.of(context).size.width);
    print("top:");
    print(left);
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
    getTimeline();
    print(top);
    //getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
//        .document(widget.currentUser.id)
//        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  buildTimeline() {
    if (posts == null) {
      top = -45 + MediaQuery.of(context).size.height / 2;
      left = -67 + (MediaQuery.of(context).size.width / 2);
      setState(() {});
      return circularProgress();
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      newsListSliver = SliverList(
          delegate: SliverChildBuilderDelegate((context, index) => posts[index],
              childCount: posts.length));

//      SliverList(
//          delegate: SliverChildBuilderDelegate((context, index) => posts[index],
//              childCount: posts.length));

//      newsListSliver=  SliverToBoxAdapter(
//        child: Container(
//          height: 100.0,
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            itemCount:  posts.length,
//            itemBuilder: (context, index) => posts[index],
//          ),
//        ),
//      );

      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverToBoxAdapter(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.sort,
              color: Colors.white,size: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  Text(
                    " GRIET",
                    style: TextStyle(letterSpacing: 2.0,

                      color: Colors.white,
                    ),
                  ),Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 10.0,)
              ],
            ),
          )
        ],
      ),
                ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height / 2) - 210,
                  ),
//                      Text(
//                        "G r i e v B o a r d",
//                        style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 24.0),
//                      ),

                  AvatarGlow(
                    endRadius: 130.0 * scale,
                    startDelay: Duration(milliseconds: 1000),
                    glowColor: Colors.white,
                    shape: BoxShape.circle,
                    animate: true,
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    //required
                    child: Material(
                      //required
                      elevation: 8.0,
                      shape: CircleBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: OutlineButton(
                        onPressed: () {
                          _controller.animateTo(
                              MediaQuery.of(context).size.height - 10,
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 500));
                        },
                        child: Text("▼ click to scroll down")),
                  )
                ],
              )),
              newsListSliver
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 0),
            top: top,
            left: left,
            child: Material(
              //required
              elevation: 8.0,
              shape: CircleBorder(),

              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return pageOne(currentUser: currentUser);
                  }));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 50.0,
                  ),
                  radius: 70.0 * scale,
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  buildUsersToFollow() {
    return StreamBuilder(
      stream:
          usersRef.orderBy('timestamp', descending: true).limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          final bool isAuthUser = currentUser.id == user.id;
          final bool isFollowingUser = followingList.contains(user.id);
          // remove auth user from recommended list
          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(user);
            userResults.add(userResult);
          }
        });

        return Container(
          color: Theme.of(context).accentColor.withOpacity(0.2),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 400.0,
                child: ColorizeAnimatedTextKit(
                  onTap: () {
                    print("tap event");
                  },
                  text: [
                    "   To Get Posts Follow The Users ",
                    "To Follow Click On The Search Box"
                  ],
                  textStyle: TextStyle(fontSize: 29.0, fontFamily: "Horizon"),
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red
                  ],
                ),
              ),

              // Text(
              //         "Users to Follow ",
              //         style: TextStyle(
              //           color: Colors.red,
              //         fontSize:30.0
              //         ),
              //         ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Users to Follow ",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Column(children: userResults),
              //MarqueeWidget(text: "welcome"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () => getTimeline(),
          child: buildTimeline(),
        ));
  }
}
