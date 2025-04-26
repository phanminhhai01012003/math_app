import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/custom_star.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class DataScreen extends StatefulWidget {
  final bool showStar;
  final int num1;
  final int num2;
  const DataScreen({super.key, this.showStar = true, required this.num1, required this.num2});

  @override
  State<DataScreen> createState() => DataScreenState();
}

class DataScreenState extends State<DataScreen> with SingleTickerProviderStateMixin{
  late AnimationController animate;
  bool isAnim = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animate.addStatusListener((s){
      if(s==AnimationStatus.completed){
        animate.reset();
        setState(() {
          isAnim = false;
        }); 
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animate.dispose();
  }
  void rotateAnimation(){
    setState(() {
      isAnim = true;
    });
    animate.forward();
  }
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool isMul = settingsProvider.settings.isMul;
    return AnimatedBuilder(
      animation: animate,
      builder: (context, child){
        return Transform.rotate(
          angle: animate.value * pi/2,
          alignment: Alignment.center,
          child: Container(
            height: 127.h,
            width: 343.w,
            decoration: BoxDecoration(
              color: CommonConstants.lightYellow,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Selector<MulProvider, int>(
                    builder: (context, val, child) => CustomStar(), 
                    selector: (p0, p1) => p1.curr!.star,
                    shouldRebuild: (previous, next) => true,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isMul ? Text("${widget.num1} x ${widget.num2} = ",
                        style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600
                        ),
                      ) : Text("${widget.num1} : ${widget.num2} = ",
                        style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 47,
                          height: 47,
                          decoration: BoxDecoration(
                            color: CommonConstants.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: CommonConstants.brownColor, width: 1),
                          ),
                          child: Text("?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: CommonConstants.brownColor
                          ),
                        ),
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
          ),
        );
      },
    );
  }
}