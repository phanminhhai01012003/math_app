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
  bool isCompleted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeLeft = widget.duration.toDouble();
    start();
  }
  void start(){
    if(isRunning || timeLeft <= 0) return;
    isRunning = true;
    timer = Timer.periodic(Duration(milliseconds: 100), (time){
      setState(() {
        timeLeft = (timeLeft - 0.1).clamp(0, widget.duration.toDouble());
        if(timeLeft <= 0 && !isCompleted){
          isCompleted = true;
          stop();
          widget.complete();
        }
      });
    });
  }
  void stop(){
    timer.cancel();
    isRunning = false;
  }
  void continueTime(){
    if(!isRunning && timeLeft > 0){
      start();
    }
  }
  void reset(){
    stop();
    setState(() {
      timeLeft = widget.duration.toDouble();
      isCompleted = false;
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