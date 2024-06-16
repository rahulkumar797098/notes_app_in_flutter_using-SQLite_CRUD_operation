import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_new/colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState() ;
  
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: appBackGround,
     body: Center(
         child: Container(
           height: 200,
             width: 200,
             child: Image.asset("assets/images/notes.png"))),
   ) ; 
  }
  
}