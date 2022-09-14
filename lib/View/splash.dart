import 'dart:async';

import 'package:covid_app/View/countries_list.dart';
import 'package:covid_app/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context)=> worldStatScreen() ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
        animation: _controller,
              child: Container(
    height:200,
        width:200,
        child: Image(image: AssetImage("images/virus.png")),

              ),

              builder: (BuildContext, Widget? child)
    {
      return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
        child: child,

      );
    },
    ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Covid-19  \n Tracker App',textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          )
        ],
      )),
    );
  }
}
