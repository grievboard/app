import 'package:flutter/material.dart';
import 'package:grievboard/utils/firebase_auth.dart';
import 'package:grievboard/Animation/FadeAnimation.dart';


class LoginPage  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(1, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/light-1.png')
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/light-2.png')
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(1.5, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/clock.png')
                        )
                      ),
                    )),
                  ),
                  Positioned(
                    child: FadeAnimation(1.6, Container(
                      margin: EdgeInsets.only(top: 90),
                      child: Center(
                        child: Text("GrievBoard \n     Login", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),),
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(35.0), 
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(13.0),
                          margin: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.black45))
                          ),
                          child: FlatButton(
                            child: Image.asset('assets/gle.png',
                             width: 800.0,
                             height: 90.0,
                            fit: BoxFit.fitWidth,
                             ),
                            onPressed: () async {
                            bool res = await AuthProvider().loginWithGoogle();
                            if(!res)
                              print("error logging in with google");
                            },
                          ),
                        ),
               ],
              ),
            )
          ],
        ),
      ),
    );
  }
}