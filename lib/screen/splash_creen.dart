import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:notes_new/colors.dart';
import 'package:notes_new/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust duration as needed
    );

    // here send image starting size and end size
    _animation = Tween<double>(begin: 50, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Timer(
            Duration(seconds: 1),
                () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            ),
          );
        }
      });

    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xe0c4fdde),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                "assets/images/notes.png",
                width: _animation.value,
                height: _animation.value,
              ),
            ),

            Expanded(
              flex: 1,
                child: Text(
                  "Note Book" , style: TextStyle(fontSize: 40  , fontWeight: FontWeight.bold , color: appTitle),))
          ],
        ),
      ),
    );
  }
}