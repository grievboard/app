import 'package:flutter/material.dart';
import 'comments.dart';
import 'postinfo.dart';
import 'package:flutter/cupertino.dart';

//pc means post comment common
class pC extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  final String gpoccontact;
  final String gpocname;
  final String name;
  final String status;
  final List consequences;
  final String description;

  pC(
      {this.postId,
      this.postOwnerId,
      this.postMediaUrl,
      this.name,
      this.consequences,
      this.gpocname,
      this.gpoccontact,
      this.status,
      this.description});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pCState();
  }
}

class pCState extends State<pC> {


  PageController pageController ;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();


  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
      print(pageIndex);
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Description"),
      ),
      body: PageView( controller: pageController,
        onPageChanged: onPageChanged,children: <Widget>[postInfo(gpoccontact: widget.gpoccontact,
        gpocname: widget.gpocname,
        name: widget.name,
        status: widget.status,
        consequences: widget.consequences,
        description: widget.description,
        postId: widget.postId,
        postOwnerId: widget.postOwnerId,
        postMediaUrl: widget.postMediaUrl,),Comments( postId: widget.postId,
        postOwnerId: widget.postOwnerId,
        postMediaUrl: widget.postMediaUrl,)],), bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.description)),
          //BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 35.0,
            ),
          ),

        ]),
    );
  }
}
