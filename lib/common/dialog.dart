import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDialog {
  void showFinishPracticeDialog(BuildContext context, VoidCallback onPressed) {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: CommonConstants.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: CommonConstants.brownColor)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(local.congratulations1, 
                  style: TextStyle(
                    color: CommonConstants.blackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 20),
                Image.asset("assets/hurrah.png",
                  fit: BoxFit.cover,
                  width: 169,
                  height: 153,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 274,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonConstants.yellowColor,
                      foregroundColor: CommonConstants.blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: CommonConstants.brownColor)
                      )
                    ),
                    onPressed: onPressed,
                    child: Text(local.awesome,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
  void showFinishTestDialog(BuildContext context, VoidCallback onPressed) {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: CommonConstants.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: CommonConstants.brownColor)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(local.congratulations2, 
                  style: TextStyle(
                    color: CommonConstants.blackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 20),
                Image.asset("assets/hurrah.png",
                  fit: BoxFit.cover,
                  width: 169,
                  height: 153,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 274,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonConstants.yellowColor,
                      foregroundColor: CommonConstants.blackColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: CommonConstants.brownColor)
                      )
                    ),
                    onPressed: onPressed,
                    child: Text(local.awesome,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
  void resetProgressDialog(BuildContext context, VoidCallback onPressed){
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: CommonConstants.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: CommonConstants.brownColor)
          ),
          child: Column(
            children: [
              Text(local.reset,
                style: TextStyle(
                  color: CommonConstants.blackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 125,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonConstants.whiteColor,
                        foregroundColor: CommonConstants.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: CommonConstants.brownColor)
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(local.cancel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CommonConstants.yellowColor,
                        foregroundColor: CommonConstants.blackColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: CommonConstants.brownColor)
                        ),
                      ),
                      onPressed: onPressed,
                      child: Text(local.ok,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}