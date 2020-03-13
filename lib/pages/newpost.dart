import 'package:flutter/material.dart';
import './upload.dart';
import '../models/user.dart';

class NewPost extends StatefulWidget {
  final User currentUser;

  NewPost({this.currentUser});

  @override
  State<StatefulWidget> createState() {
    return NewPostState();
  }
}

//Center(child: OutlineButton(onPressed: () {
//Navigator.push(context, MaterialPageRoute(builder: (context) {
//return Upload(currentUser: widget.currentUser);
//}));
//}),)
class NewPostState extends State<NewPost> {
  static var temp = "hello";
  TextEditingController inBox = new TextEditingController();

  List<String> consequences = [];
  var length;

  @override
  initState() {
    temp = "hello";
  }

  int currentStep = 0;
  bool complete = false;

  next() {
    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  List<Step> giveShit() {
    return [
      Step(
        title: const Text('What is the Problem'),
        isActive: true,
        state: StepState.complete,
        content: Container(
          height: MediaQuery.of(context).size.height - 400,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Type it here'),
              ),

            ],
          ),
        ),
      ),
      Step(
        isActive: false,
        state: StepState.editing,
        title: const Text('Consequences'),
        content: Container(
          height: MediaQuery.of(context).size.height - 400,
          child: Column(
            children: <Widget>[
              Container(
                height: 300.0,
                child: ListView.builder(
                    itemCount: consequences.length,
                    itemBuilder: (context, i) {
                      return OutlineButton(onPressed: (){},child: Text(consequences[i]),);
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        title: Text("Add Consequence"),
                        content: TextField(controller: inBox,),
                        actions: <Widget>[
                          MaterialButton(
                            child: Text("add"),
                            onPressed: () {
                              consequences.add(inBox.text);
                              inBox.text="";
                              setState(() {

                              });
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      Step(
        state: StepState.editing,
        title: const Text('Add  photo'),
        subtitle: const Text("Further support the problem"),
        content: Container(
          height: 500.0,
          child: PageView(
            children: <Widget>[
              Upload(currentUser: widget.currentUser),
            ],
//          controller: pageController,
//          onPageChanged: onPageChanged,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
      Step(
        title: const Text('New Account'),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hello"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              constraints: BoxConstraints.expand(),
              child: Stepper(
                type: StepperType.vertical,
                steps: giveShit(),
                currentStep: currentStep,
                onStepContinue: next,
                onStepTapped: (step) => goTo(step),
                onStepCancel: cancel,
              ),
            ))
          ],
        ));
  }
}
