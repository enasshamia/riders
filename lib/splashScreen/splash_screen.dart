import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lhad_albiet_riders/authenctication/auth_screen.dart';
import 'package:lhad_albiet_riders/global/global.dart';
import 'package:lhad_albiet_riders/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){


    Timer(const Duration(seconds: 5),() async {

      // if seller logedin
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      else{
        Navigator.push(context,MaterialPageRoute(builder: (c)=> const AuthScreen()));

      }

    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),
              const SizedBox(height: 10,),
              const Padding(
                  padding:  EdgeInsets.all(18.0),
                  child: Text(
                    "online food app",
                    textAlign:TextAlign.center ,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      letterSpacing: 2,
                      fontFamily: "Signatra",

                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
