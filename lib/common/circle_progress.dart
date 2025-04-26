import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class CircleProgress extends StatelessWidget {
  bool selected;
  String operation;
  String percentage;
  double val;
  CircleProgress({super.key, required this.selected, required this.operation, required this.percentage, required this.val});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool isMul = settingsProvider.settings.isMul;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 126.w,
          height: 126.h,
          child: CircularProgressIndicator(
            value: val,
            strokeWidth: 3,
            backgroundColor: CommonConstants.greyColor,
            color: selected ? CommonConstants.greenColor : CommonConstants.lightYellow2,
          ),
        ),
        InkWell(
          onTap: () => settingsProvider.updateMode(isMul),
          child: Container(
            width: 96.w,
            height: 96.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? CommonConstants.greenColor : CommonConstants.whiteColor,
              border: Border.all(color: selected ? CommonConstants.green2Color : CommonConstants.lightYellow2),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(operation,
                  style: TextStyle(
                    color: selected ? CommonConstants.whiteColor : CommonConstants.blackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(selected ? percentage : "", 
                  style: TextStyle(
                    color: CommonConstants.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}