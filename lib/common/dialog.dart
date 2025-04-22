import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class CustomDialog {
  void showFinishDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CommonConstants.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: CommonConstants.brownColor)
            ),
            child: Column(
              children: [
                Text("Chúc mừng! Bạn đã hoàn thành bài kiểm tra", 
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
                      foregroundColor: CommonConstants.blackColor
                    ),
                    onPressed: () {

                    },
                    child: Text("Tuyệt vời",
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
}