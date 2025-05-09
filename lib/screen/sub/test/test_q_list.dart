import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/answer_record.dart';
import 'package:provider/provider.dart';
class TestQList extends StatefulWidget {
  final List<AnswerRecord> list;
  const TestQList({super.key, required this.list});

  @override
  State<TestQList> createState() => _TestQListState();
}

class _TestQListState extends State<TestQList> {
  
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final provider = context.watch<SettingsProvider>();
    bool isMul = provider.settings.isMul;
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
          isMul ? mulList(context) : divList(context)
        ],
      ),
    );
  }
  Widget mulList(BuildContext context){
    final local = AppLocalizations.of(context)!;
    return Consumer<MulProvider>(
      builder: (context, mulProvider, child){
        return widget.list.isEmpty ? Center(
          child: Text(local.noanswer,
            style: TextStyle(
              color: CommonConstants.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500
            ),
          ),
        ) : Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 60.h, left: 30.w, right: 30.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
            height: 666.h,
            width: 343.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: CommonConstants.lightYellow2,
                  offset: Offset(0, 5)
                )
              ]
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: widget.list.length,
              itemBuilder: (context, index){
                AnswerRecord ans = widget.list[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    children: [
                      Icon(
                        ans.isCorrect ? Icons.check : Icons.cancel,
                        size: 24,
                        color: ans.isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "${ans.num1} x ${ans.num2} = ${ans.selected}",
                          style: TextStyle(
                            color: ans.isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
  Widget divList(BuildContext context){
    final local = AppLocalizations.of(context)!;
    return Consumer<MulProvider>(
      builder: (context, mulProvider, child){
        return widget.list.isEmpty ? Center(
          child: Text(local.noanswer,
            style: TextStyle(
              color: CommonConstants.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500
            ),
          ),
        ) : Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 60.h, left: 30.w, right: 30.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
            height: 666.h,
            width: 343.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: CommonConstants.lightYellow2,
                  offset: Offset(0, 5)
                )
              ]
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: widget.list.length,
              itemBuilder: (context, index){
                AnswerRecord ans = widget.list[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    children: [
                      Icon(
                        ans.isCorrect ? Icons.check : Icons.cancel,
                        size: 24,
                        color: ans.isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "${ans.num1} : ${ans.num2} = ${ans.selected}",
                          style: TextStyle(
                            color: ans.isCorrect ? CommonConstants.greenColor : CommonConstants.redColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    );
  }
}