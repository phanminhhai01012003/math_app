import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/count_down.dart';
import 'package:math_app/common/dialog.dart';
import 'package:math_app/core/provider/div_provider.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/answer_record.dart';
import 'package:math_app/model/div_model.dart';
import 'package:math_app/model/mul_model.dart';
import 'package:math_app/screen/sub/completed/result.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String input = "";
  List<dynamic> qList = [];
  List<AnswerRecord> ansHistory = [];
  bool isProcessing = false, 
  showRes = false, 
  timeup = false, 
  isLoading = false;
  int currQuestionIndex = 0;
  CustomDialog dialog = CustomDialog();
  final GlobalKey<CountDownState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
      final isMul = settingsProvider.settings.isMul;
      setState(() {
        if(isMul){
          final mulProvider = Provider.of<MulProvider>(context, listen: false);
          qList = mulProvider.getMultiAnswer();
        }else{
          final divProvider = Provider.of<DivProvider>(context, listen: false);
          qList = divProvider.getDivisionAnswer();
        }
      });
      await Future.delayed(const Duration(seconds: 2));
    });
  }
  void timeUp(){
    if(!mounted || isProcessing) return;
    handleAnswer(input.isEmpty ? "?" : input);
  }
  void numberPress(int num){
    if(input.length < 4 && !isProcessing && !timeup) {
      setState(() {
        input+=num.toString();
      });
    }
  }
  void cancelPress(){
    if(!isProcessing && input.isNotEmpty){
      setState(() {
        input = input.substring(0, input.length-1);
      });
    }
  }
  void handleAnswer(String ans){
    if(qList.isEmpty) return;
    final currQuestion = qList[currQuestionIndex]; 
    final inputRes = int.tryParse(ans) ?? 0;
    late int corrRes;
    late int num1, num2;
    if(currQuestion is MulModel){
      corrRes = currQuestion.res;
      num1 = currQuestion.num1;
      num2 = currQuestion.num2;
    }else if(currQuestion is DivModel){
      corrRes = currQuestion.res;
      num1 = currQuestion.num1;
      num2 = currQuestion.num2;
    }else {return;}
    final bool isCorrect = inputRes == corrRes;
    setState(() {
      isProcessing = true;
      showRes = true;
      ansHistory.add(AnswerRecord(
        num1: num1,
        num2: num2,
        res: corrRes,
        selected: inputRes,
        isCorrect: isCorrect,
        star: 0,
      ));
    });
    Future.delayed(Duration(milliseconds: 500), (){
      if(!mounted) return;
      if(currQuestionIndex>=9){
        final correctCount = ansHistory.where((a)=>a.isCorrect).length;
        dialog.showFinishTestDialog(context, (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Result(
            correctCount: correctCount,
            wrongCount: 10-correctCount,
            total: 10,
            ansHistory: ansHistory,
            isTesting: true,
          )));
        }); 
      }else{
        setState(() {
          currQuestionIndex++;
          input = "";
          showRes = false;
          isProcessing = false;
          timeup = false;
        });
        _key.currentState?.reset();
      }
    });
  }
  void checkAnswer() => handleAnswer(input);
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    Future.delayed(Duration(seconds: 2));
    return Consumer<SettingsProvider>(
      builder: (context, settings, child){
        if(qList.isEmpty){
          return Scaffold(
            backgroundColor: CommonConstants.whiteColor,
            appBar: AppBar(
              backgroundColor: CommonConstants.whiteColor,
              leading: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: CommonConstants.yellowColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: CommonConstants.brownColor, width: 1),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back,
                      color: CommonConstants.blackColor,
                      size: 30,
                    ),
                  ),
                 ),
               ),
            ),
            title: Text(local.test,
              style: TextStyle(
             color: CommonConstants.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            ),
          centerTitle: true,
          actions: [
            Padding(
             padding: EdgeInsets.all(12),
             child: Text("${currQuestionIndex + 1}/10"),
            ),
            ],
          ),
          body: Center(child: CircularProgressIndicator())
          );
        }
        final currQuestion = qList[currQuestionIndex];
        String qText;
        if(currQuestion is MulModel){
          qText = "${currQuestion.num1} x ${currQuestion.num2} = ";
        }else if(currQuestion is DivModel){
          qText = "${currQuestion.num1} : ${currQuestion.num2} = ";
        }else {
          qText = "?";
        }
        return Scaffold(
          backgroundColor: CommonConstants.whiteColor,
          appBar: AppBar(
            backgroundColor: CommonConstants.whiteColor,
            leading: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: CommonConstants.yellowColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: CommonConstants.brownColor, width: 1),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_back,
                    color: CommonConstants.blackColor,
                    size: 30,
                  ),
                ),
            ),
          ),
        ),
        title: Text(local.test,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text("${currQuestionIndex + 1}/10"),
          ),
        ],
      ),
      body: Column(
        children: [
          CountDown(
            key: _key,
            duration: settingsProvider.settings.answerTime,
            height: 8.h,
            complete: timeUp,
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                Container(
                  height: 127.h,
                  width: 343.w,
                  decoration: BoxDecoration(
                    color: CommonConstants.lightYellow,
                    borderRadius: BorderRadius.circular(12.r)
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          qText,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: CommonConstants.whiteColor,
                            border: Border.all(color: CommonConstants.brownColor),
                            borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Center(
                            child: Text(input.isEmpty ? "?" : input,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: CommonConstants.brownColor
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonNumber(1),
                    buttonNumber(2),
                    buttonNumber(3),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonNumber(4),
                    buttonNumber(5),
                    buttonNumber(6)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buttonNumber(7),
                    buttonNumber(8),
                    buttonNumber(9)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    clearButton(),
                    buttonNumber(0),
                    acceptButton()
                  ],
                ),
              ],
            ),
          ),
        ],
      )
        );
      },
    );
  }
  Widget buttonNumber(int num){
    return GestureDetector(
      onTap: () => numberPress(num),
      child: Container(
        width: 92,
        height: 68,
        decoration: BoxDecoration(
          color: CommonConstants.yellowColor,
          border: Border.all(color: CommonConstants.brownColor),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Center(
          child: Text("${num}",
            style: TextStyle(
              color: CommonConstants.brownColor,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
  Widget clearButton(){
    return GestureDetector(
      onTap: cancelPress,
      child: Container(
        width: 92,
        height: 68,
        decoration: BoxDecoration(
          color: CommonConstants.whiteColor,
          border: Border.all(color: CommonConstants.redColor),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Center(
          child: Icon(Icons.backspace_outlined,
            size: 40,
            color: CommonConstants.redColor,
          ),
        ),
      ),
    );
  }
  Widget acceptButton(){
    return GestureDetector(
      onTap: checkAnswer,
      child: Container(
        width: 92,
        height: 68,
        decoration: BoxDecoration(
          color: CommonConstants.greenColor,
          border: Border.all(color: CommonConstants.brownColor),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Center(
          child: Icon(Icons.check,
            size: 40,
            color: CommonConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}