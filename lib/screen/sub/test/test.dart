import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String input = "";
  int num1 = 1, num2 = 6;
  bool isCorrect = false, showRes = false;
  int questionCount = 0, correctCount = 0, wrongCount = 0;
  void numberPress(int num){
    if(input.length < 3) {setState(() {
      input+=num.toString();
    });}
  }
  void cancelPress(){
    setState(() {
      if(input.isNotEmpty){input = input.substring(0, input.length-1);}
    });
  }
  void checkAnswer(){
    if(input.isNotEmpty) {
      final int correctResult = num1 * num2;
      final int userRes = int.parse(input);
      setState(() {
        isCorrect = userRes == correctResult;
        showRes = true;
        questionCount++;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
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
        title: Text("Kiểm tra",
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Divider(color: CommonConstants.brownColor, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              width: double.infinity,
              height: 127,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CommonConstants.lightYellow,
                borderRadius: BorderRadius.circular(14) 
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${num1} x ${num2} = ",
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Container(
                      height: 40.h,
                      width: 86.w,
                      decoration: BoxDecoration(
                        color: CommonConstants.whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: showRes ? Border.all(
                          color: isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                          width: 2.w,
                        ) : null
                      ),
                      child: Center(
                        child: Text(
                          input.isEmpty ? "?" : input,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: showRes ? 
                            (isCorrect ? CommonConstants.greenColor : CommonConstants.redColor) :
                            CommonConstants.blackColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonNumber(7),
              buttonNumber(8),
              buttonNumber(9),
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
              buttonNumber(1),
              buttonNumber(2),
              buttonNumber(3)
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
      )
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