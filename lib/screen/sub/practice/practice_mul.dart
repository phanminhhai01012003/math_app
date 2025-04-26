import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/screen/sub/practice/choose_result_mul.dart';
import 'package:math_app/screen/sub/practice/data_screen.dart';
import 'package:math_app/screen/sub/practice/practice.dart';
import 'package:provider/provider.dart';

class PracticeMul extends StatefulWidget {
  const PracticeMul({super.key});

  @override
  State<PracticeMul> createState() => _PracticeMulState();
}

class _PracticeMulState extends State<PracticeMul> {
  List<String> dotImages = [
    "assets/dot/dot1.png",
    "assets/dot/dot2.png",
    "assets/dot/dot3.png",
    "assets/dot/dot4.png",
    "assets/dot/dot5.png",
    "assets/dot/dot6.png",
    "assets/dot/dot7.png",
    "assets/dot/dot8.png",
    "assets/dot/dot9.png",
    "assets/dot/dot10.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MulProvider>(
      builder: (context, mulProvider, child) {
        final mul = mulProvider.curr;
        return Column(
          children: [
            Divider(color: CommonConstants.brownColor, thickness: 1),
            SizedBox(height: 20.h),
            mul == null ? Center(child: CircularProgressIndicator()) : 
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  DotImages(dotImages: dotImages),
                  DataScreen(num1: mul.num1, num2: mul.num2),
                  SizedBox(height: 80.h),
                  ChooseResultMul(
                    currMul: mul,
                    showNext: () {},
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}