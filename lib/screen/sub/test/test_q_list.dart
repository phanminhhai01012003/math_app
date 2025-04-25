import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/model/answer_record.dart';
class TestQList extends StatefulWidget {
  const TestQList({super.key});

  @override
  State<TestQList> createState() => _TestQListState();
}

class _TestQListState extends State<TestQList> {
  List<AnswerRecord> list = [];
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
        leading: Padding(
          padding: EdgeInsets.all(12),
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
        title: Text(local.qList,
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
            padding: EdgeInsets.all(24.r),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 5,
                    color: CommonConstants.lightYellow2,
                    offset: Offset(0, 5)
                  )
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final ans = list[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          ans.isCorrect ? Icons.check : Icons.cancel,
                          size: 20.w,
                          color: ans.isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                        ),
                        SizedBox()
                      ],
                    ),
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }
}