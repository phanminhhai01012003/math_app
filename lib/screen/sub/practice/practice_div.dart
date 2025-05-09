import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/div_provider.dart';
import 'package:math_app/screen/sub/practice/choose_result_div.dart';
import 'package:math_app/screen/sub/practice/data_screen.dart';
import 'package:math_app/screen/sub/practice/dot_images.dart';
import 'package:provider/provider.dart';

class PracticeDiv extends StatefulWidget {
  const PracticeDiv({super.key});

  @override
  State<PracticeDiv> createState() => _PracticeDivState();
}

class _PracticeDivState extends State<PracticeDiv> {
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
  final GlobalKey<DataScreenState> key = GlobalKey<DataScreenState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<DivProvider>(
      builder: (context, divProvider, child){
        final div = divProvider.curr;
        return Column(
          children: [
            Divider(color: CommonConstants.brownColor, thickness: 1),
            SizedBox(height: 20.h),
            div == null ? Center(child: CircularProgressIndicator()) : 
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  DotImages(dotImages: dotImages),
                  DataScreen(key: key, num1: div.num1, num2: div.num2),
                  SizedBox(height: 80.h),
                  ChooseResultDiv(
                    currDiv: div,
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