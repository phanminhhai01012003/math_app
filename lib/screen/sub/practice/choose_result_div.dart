import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/dialog.dart';
import 'package:math_app/core/provider/div_provider.dart';
import 'package:math_app/model/div_model.dart';
import 'package:math_app/screen/sub/completed/result.dart';
import 'package:math_app/screen/sub/practice/data_screen.dart';
import 'package:provider/provider.dart';

class ChooseResultDiv extends StatefulWidget {
  final DivModel currDiv;
  final Function showNext;
  const ChooseResultDiv({super.key, required this.currDiv, required this.showNext});

  @override
  State<ChooseResultDiv> createState() => _ChooseResultDivState();
}

class _ChooseResultDivState extends State<ChooseResultDiv> {
  List<int> resList = [];
  Set<int> wrongAnswers = {};
  int? selectedAnswer;
  bool? isCorrectAnswer;
  bool isProcessing = false;
  late DivModel div;
  final GlobalKey<DataScreenState> key = GlobalKey<DataScreenState>();
  CustomDialog dialog = CustomDialog();
  void initState() {
    // TODO: implement initState
    super.initState();
    div = widget.currDiv;
    _genAnsOptions();
  }
  @override
  void didUpdateWidget(covariant ChooseResultDiv oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.currDiv.num1 != widget.currDiv.num1 || oldWidget.currDiv.num2 != widget.currDiv.num2){
      div = widget.currDiv;
      _genAnsOptions();
      setState(() {
        selectedAnswer = null;
        isCorrectAnswer = null;
        wrongAnswers.clear();
        isProcessing = false;
      });
    }
  }
  void _genAnsOptions(){
    resList.clear();
    resList.add(div.res);
    final random = Random();
    final int correctRes = div.res;
    final int minRange = max(1, (correctRes*0.8).toInt());
    final int maxRange = max(minRange+10, (correctRes*1.2).toInt());
    while(resList.length < 4){
      int wrongAnswers = minRange+random.nextInt(maxRange-minRange);
      if(wrongAnswers!=correctRes && !resList.contains(wrongAnswers)){
        resList.add(wrongAnswers);
      }
    }
    resList.shuffle();
  }
  Future<void> handleAnswer(int selected) async{
    if(isProcessing) return;
    final bool isCorrect = selected == widget.currDiv.res;
    final divProvider = Provider.of<DivProvider>(context, listen: false);
    setState(() {
      isProcessing = true;
      selectedAnswer = selected;
      isCorrectAnswer = isCorrect;
      if(!isCorrect) wrongAnswers.add(selected); 
    });
    await divProvider.recordAnswer(selected);
    if(isCorrect) {
      key.currentState?.rotateAnimation();
      await Future.delayed(Duration(seconds: 1));
      if(!mounted) return;
      if(divProvider.isCompleted){
        dialog.showFinishPracticeDialog(context, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Result(
              correctCount: divProvider.correctCount,
              wrongCount: divProvider.wrongCount,
              total: 10,
            ))
          );
        });
      }
    } else{
      await Future.delayed(Duration(milliseconds: 500));
    }
    if(mounted){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        isProcessing=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.5,
            children: resList.map((a){
              bool isWrong = wrongAnswers.contains(a);
              bool isSelected = selectedAnswer == a;
              bool isCorrect = a==widget.currDiv.res;
              Color bgColor = CommonConstants.whiteColor;
              if(isSelected){
                bgColor = isCorrect ? CommonConstants.greenColor : CommonConstants.redColor;
              }
              return GestureDetector(
                onTapDown: (_){
                  if(!isWrong && !isProcessing){
                    setState(() {
                      selectedAnswer = a;
                    });
                  }
                },
                onTapUp: (_){
                  if(!isWrong && !isProcessing){
                    setState(() {
                      handleAnswer(a);
                    });
                  }
                },
                onTapCancel: (){
                  if(!isWrong && !isProcessing){
                    setState(() {
                      selectedAnswer = null;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInCubic,
                  transform: selectedAnswer == a ? Matrix4.translationValues(0, 1, 0) : Matrix4.identity(),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(
                      color: selectedAnswer == a ? CommonConstants.brownColor : CommonConstants.green2Color, 
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(12.r)
                  ),
                  child: Center(
                    child: Text(a.toString(),
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}