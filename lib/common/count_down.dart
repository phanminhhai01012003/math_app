import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class CountDown extends StatefulWidget {
  int duration;
  VoidCallback complete;
  double height;
  CountDown({super.key, required this.duration, required this.complete, required this.height});

  @override
  State<CountDown> createState() => CountDownState();
}

class CountDownState extends State<CountDown> {
  late Timer timer;
  double timeLeft = 0;
  bool isRunning = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeLeft = widget.duration.toDouble();
    start();
  }
  void start(){
    if(isRunning) return;
    isRunning = true;
    timer = Timer.periodic(Duration(milliseconds: 100), (time){
      if(timeLeft>0) setState(() {
        timeLeft -= 0.1;
      });
      else stop();
      widget.complete();
    });
  }
  void stop(){
    timer.cancel();
    isRunning = false;
  }
  void reset(){
    stop();
    setState(() {
      timeLeft = widget.duration.toDouble();
    });
    start();
  }
  @override
  Widget build(BuildContext context) => Column(
    children: [
      LinearProgressIndicator(
        value: timeLeft / widget.duration,
        backgroundColor: CommonConstants.brownColor,
        valueColor: AlwaysStoppedAnimation<Color>(CommonConstants.darkyellowColor),
        minHeight: widget.height,
      )
    ],
  );
}