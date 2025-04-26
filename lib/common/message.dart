import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';

class Message {
  void showSuccessMessage(BuildContext context, String title){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,
        style: TextStyle(
          color: CommonConstants.whiteColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: CommonConstants.greenColor,
      behavior: SnackBarBehavior.floating,
      elevation: 1,
    ));
  }
  void showErrorMessage(BuildContext context, String title){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,
        style: TextStyle(
          color: CommonConstants.whiteColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: CommonConstants.redColor,
      behavior: SnackBarBehavior.floating,
      elevation: 1,
    ));
  }
}