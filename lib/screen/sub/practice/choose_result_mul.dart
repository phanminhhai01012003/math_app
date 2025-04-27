import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/dialog.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/mul_model.dart';
import 'package:math_app/screen/sub/completed/result.dart';
import 'package:math_app/screen/sub/practice/data_screen.dart';
import 'package:provider/provider.dart';

class ChooseResultMul extends StatefulWidget {
  final MulModel? currMul;
  final Function showNext;
  const ChooseResultMul({super.key, required this.currMul, required this.showNext});

  @override
  State<ChooseResultMul> createState() => _ChooseResultMulState();
}

class _ChooseResultMulState extends State<ChooseResultMul> {
  List<int> resList = [];
  Set<int> wrongAnswers = {};
  int? selectedAnswer;
  bool? isCorrectAnswer;
  bool isProcessing = false;
  final random = Random();
  CustomDialog dialog = CustomDialog();
  GlobalKey<DataScreenState> key = GlobalKey<DataScreenState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genAnsOptions();
  }
  @override
  void didUpdateWidget(covariant ChooseResultMul oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.currMul != oldWidget.currMul){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        wrongAnswers.clear();
        isProcessing=false;
      });
      _genAnsOptions();
    }
  }
  void _genAnsOptions(){
    if(widget.currMul==null) return;
    resList.clear();
    resList.add(widget.currMul!.res);
    final int correctRes = widget.currMul!.res;
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
    if(widget.currMul == null || isProcessing) return;
    setState(() {
      isProcessing = true;
      selectedAnswer = selected;
    });
    final bool isCorrect = selected == widget.currMul!.res;
    final multiProvider = Provider.of<MulProvider>(context, listen: false);
    setState(() {
      isCorrectAnswer = isCorrect;
      if(!isCorrect) wrongAnswers.add(selected); 
    });
    if(isCorrect) {
      key.currentState?.rotateAnimation();
      await Future.delayed(Duration(seconds: 1));
      await multiProvider.recordAnswer(isCorrect, selected);
      if(!mounted) return;
      if(multiProvider.correctCount >= 10){
        final settings = Provider.of<SettingsProvider>(context, listen: false);
        settings.updateProcess(true,
        (multiProvider.sumStar(multiProvider.multiplications) ~/ 144 * 100)
        );
        dialog.showFinishPracticeDialog(context, (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Result(
              correctCount: multiProvider.correctCount,
              wrongCount: multiProvider.wrongCount,
              total: 10,
            ))
          );
        });
      }
    } else{
      await multiProvider.recordAnswer(isCorrect, selected);
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
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.5,
            children: resList.map((a){
              bool isWrong = wrongAnswers.contains(a);
              bool isSelected = selectedAnswer == a;
              bool isCorrect = a==widget.currMul?.res;
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
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(
                      color: selectedAnswer == a ? Colors.transparent : CommonConstants.brownColor, 
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