import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/div_provider.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/answer_record.dart';
import 'package:math_app/screen/main/home.dart';
import 'package:math_app/screen/sub/practice/practice_q_list.dart';
import 'package:math_app/screen/sub/test/test_q_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Result extends StatefulWidget {
  final int correctCount;
  final int wrongCount;
  final int total;
  final int stars;
  final bool isTesting;
  final List<AnswerRecord>? ansHistory;
  const Result({
    super.key,
    required this.correctCount,
    required this.wrongCount,
    this.total = 10,
    this.stars = 0,
    this.isTesting = false,
    this.ansHistory 
  });

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final isMul = settingsProvider.settings.isMul;
    final mulProvider = Provider.of<MulProvider>(context);
    int process = widget.isTesting ? 0 : mulProvider.sumStar(mulProvider.multiplications);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
        title: Text(local.result,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: CommonConstants.brownColor, thickness: 1),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!widget.isTesting) ...[
                  Transform.rotate(
                    angle: 7.26 * pi / 180,
                    child: Text(
                      local.progress,
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 113.w),
                    child: Image.asset(
                      "assets/vector.png",
                      fit: BoxFit.cover,
                      width: 7.58.w,
                      height: 15.5.h,
                    ),
                  ),
                  SizedBox(height: 7.5.h),
                  Container(
                    width: 343.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    child: LinearProgressIndicator(
                      backgroundColor: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(12.r),
                      value: isMul ? process / 144 : 0.0,
                      valueColor: AlwaysStoppedAnimation<Color>(CommonConstants.brownColor),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      correctBox(widget.correctCount.toString(), local.correct),
                      incorrectBox(widget.wrongCount.toString(), local.incorrect)
                    ],
                  ),
                  SizedBox(height: 16.h),
                  actionButton(local, isMul),
                ]else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (index) => Container(
                      alignment: Alignment.center,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: CommonConstants.greenColor,
                        borderRadius: BorderRadius.circular(48)
                      ),
                      child: Icon(Icons.check,
                        size: 30,
                        color: CommonConstants.whiteColor,
                      ),
                    )),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      correctBox(widget.correctCount.toString(), local.correct),
                      incorrectBox(widget.wrongCount.toString(), local.incorrect)
                    ],
                  ),
                  SizedBox(height: 32.h),
                  actionButton(local, isMul)
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget correctBox(String number, String label){
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        color: CommonConstants.greenColor,
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number,
            style: TextStyle(
              color: CommonConstants.whiteColor,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 10.h),
          Text(label,
            style: TextStyle(
              color: CommonConstants.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp
            ),
          )
        ],
      ),
    );
  }
  Widget incorrectBox(String number, String label){
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        color: CommonConstants.redColor,
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number,
            style: TextStyle(
              color: CommonConstants.whiteColor,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 10.h),
          Text(label,
            style: TextStyle(
              color: CommonConstants.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp
            ),
          )
        ],
      ),
    );
  }
  Widget actionButton(AppLocalizations local, bool isMul){
    return Column(
      children: [
        SizedBox(height: 32.h),
        SizedBox(
          width: 343.w,
          height: 60.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonConstants.yellowColor,
              foregroundColor: CommonConstants.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: CommonConstants.brownColor, width: 1)
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, 
              MaterialPageRoute(
                builder: (context) => widget.isTesting && widget.ansHistory != null  
                ? TestQList(list: widget.ansHistory!) 
                : const PracticeQList()));
            },
            child: Row(
              children: [
                Icon(Icons.list_alt_rounded,
                  size: 20,
                ),
                SizedBox(width: 22),
                Text(local.qList, 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 343.w,
          height: 60.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonConstants.yellowColor,
              foregroundColor: CommonConstants.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: CommonConstants.brownColor, width: 1)
              ),
            ),
            onPressed: () {
              if(!widget.isTesting){
                if(isMul){
                  Provider.of<MulProvider>(context, listen: false).filterCorrectAnswers();
                }else{
                  Provider.of<DivProvider>(context, listen: false).filterCorrectAnswers();
                }
              }
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(Icons.refresh_outlined,
                  size: 20,
                ),
                SizedBox(width: 22),
                Text(local.again, 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 343.w,
          height: 60.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CommonConstants.whiteColor,
              foregroundColor: CommonConstants.blackColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: CommonConstants.brownColor, width: 1)
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back,
                  size: 20,
                ),
                SizedBox(width: 22),
                Text("Menu", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}