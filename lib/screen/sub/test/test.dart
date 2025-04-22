import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
        leading: GestureDetector(
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
        title: Text("Kiểm tra",
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
            padding: EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CommonConstants.lightYellow,
                borderRadius: BorderRadius.circular(14) 
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("10 x 9 = ",
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(
                      width: 76,
                      height: 46,
                      child: TextField(
                        
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [

            ],
          )
        ],
      )
    );
  }
  void buttonNumber(int num){
    Container(
      width: 92,
      height: 68,
      decoration: BoxDecoration(
        color: CommonConstants.yellowColor,
        border: Border.all(color: CommonConstants.brownColor),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Center(
        child: Text("${num}",
          style: TextStyle(
            color: CommonConstants.brownColor,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  void clearButton(){
    Container(
      decoration: BoxDecoration(
        color: CommonConstants.whiteColor,
        border: Border.all(color: CommonConstants.redColor),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Center(
        child: Icon(Icons.backspace_outlined,
          size: 20,
          color: CommonConstants.redColor,
        ),
      ),
    );
  }
  void acceptButton(){
    Container(
      decoration: BoxDecoration(
        color: CommonConstants.greenColor,
        border: Border.all(color: CommonConstants.brownColor),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Center(
        child: Icon(Icons.check,
          size: 20,
          color: CommonConstants.redColor,
        ),
      ),
    );
  }
}