import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStar extends StatelessWidget {
  int count;
  CustomStar({super.key, this.count = 1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98.w,
      height: 18.h,
      child: Row(
        children: List.generate(5, (i) => Icon(
          Icons.star,
          size: 18.sp,
          color: i < count ? Colors.amber : Colors.grey,
        )),
      ),
    );
  }
}