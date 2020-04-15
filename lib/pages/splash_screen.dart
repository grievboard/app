//import 'package:fade/fade.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_fadein/flutter_fadein.dart';
import 'dart:async';

import 'package:grievboard/pages/home.dart';
//import 'package:grievboard/utils/FadeAnimation.dart';
//import 'package:grievboard/utils/fadeAnimationbottom.dart';
//import 'package:shimmer/shimmer.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visibile = true;

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
        (status) {
          
            _navigateToHome();
          
        }
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 3), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => Home()
      )
    );
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
	        child: Column(
	          children: <Widget>[
	            Container(
	              height: 870,
                width: 400,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('assets/images/1.png'),
	                  fit: BoxFit.fill
	                )
	              ),
                
	              child: Stack(
	                children: <Widget>[
                    
	                  Positioned(
                      top: 35,
	                    left: -10,
	                    width: 530,
	                    height: 900,
	                    
                      child:Container(
                        
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/7.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
                      top: 100,
                      
	                    left: -235,
	                    width: 880,
	                    height: 650,
	                   
                      child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/3.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    right: -50,
	                    top: 30,
	                    width: 580,
	                    height: 950,
	                    
                      child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/4.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    right: -93,
	                    top: 140,
	                    width: 600,
	                    height: 700,
	                    
                      child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/5.png')
	                        )
	                      ),
	                    ),
	                  ),
                    Positioned(
	                    right: -310,
	                    top: 120,
	                    width: 980,
	                    height: 690,
	                    
                      child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/6.png')
	                        )
	                      
	                    ),
                      ),
	                  ),
                    Positioned(
	                    right: -250,
	                    top: 100,
	                    width: 880,
	                    height: 650,
	                    
                      child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/2.png')
	                        )
	                      ),
	                    ),
	                  ),
                    Positioned(
	                    right: -85,
	                    top: -30,
	                    width: 580,
	                    height: 850,
	                    
                      child:
                       Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
                            
	                          image: AssetImage('assets/images/8.png')
	                        )
	                      ),
	                    ),
	                  ),
	                ],
	              ),
	            ),
	          ],
	        ),
	      ),
      ),
    );
  }


}