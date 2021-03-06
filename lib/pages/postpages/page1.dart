import 'package:flutter/material.dart';
import 'page2.dart';
import 'package:grievboard/models/user.dart';
import 'package:grievboard/pages/upload.dart';

Function refresh;



class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;

  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class pageOne extends StatefulWidget {
  final User currentUser;
  Function temp;

  pageOne({this.currentUser,this.temp});

  @override
  State<StatefulWidget> createState() {
    return pageOneState();
  }
}

//MaterialPageRoute(builder: (context) {
//return pageTwo(currentUser: widget.currentUser);
//})

class pageOneState extends State<pageOne> {
  TextEditingController name = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    refresh=widget.temp;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Name"),
      ),
      body: Column(
        children: <Widget>[
          Text('What is the Problem'),
          TextFormField(
            controller: name,
            decoration: InputDecoration(labelText: 'Type it here'),
          ),
          SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              Navigator.push(
                  context,
                  SlideLeftRoute(
                      page: pageTwo(currentUser: widget.currentUser,name: name.text,)));
            },
          )
        ],
      ),
    );
  }
}

class pageTwo extends StatefulWidget {
  final User currentUser;
  String name;

  pageTwo({this.currentUser,this.name});

  @override
  State<StatefulWidget> createState() {
    return pageTwoState();
  }
}

class pageTwoState extends State<pageTwo> {
  List<String> consequences = [];
  static var temp = "hello";
  TextEditingController inBox = new TextEditingController();

  var length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text("List of consequences"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: ListView.builder(
                itemCount: consequences.length,
                itemBuilder: (context, i) {
                  return OutlineButton(
                    onPressed: () {},
                    child: Text(consequences[i]),
                  );
                }),
          ),
          OutlineButton(
            child: Text("Add consequence"),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    title: Text("Add Consequence"),
                    content: TextField(
                      controller: inBox,
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        child: Text("add"),
                        onPressed: () {
                          consequences.add(inBox.text);
                          inBox.text = "";
                          setState(() {});
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              Navigator.push(
                  context,
                  SlideLeftRoute(
                      page: pageThree(currentUser: widget.currentUser,consequences: consequences,name: widget.name,)));
            },
          )
        ],
      ),
    );
  }
}

class pageThree extends StatefulWidget {
  final User currentUser;
  List<String> consequences = [];
  String name;
  pageThree({this.currentUser,this.name,this.consequences});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return pageThreeState();
  }
}

class pageThreeState extends State<pageThree> {
  TextEditingController desc = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Description"),
      ),
      body: Column(
        children: <Widget>[
          Text('Describe Problem'),
          TextFormField(
            controller: desc,
            decoration:
                InputDecoration(labelText: 'Type it here', hintMaxLines: 20),
          ),
          SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              Navigator.push(
                  context,
                  SlideLeftRoute(
                      page: Upload(
                    currentUser: widget.currentUser,
                    name: widget.name,
                    desc: desc.text,
                    consequences: widget.consequences,
                        refresh: refresh,
                  )));
            },
          )
        ],
      ),
    );
  }
}
