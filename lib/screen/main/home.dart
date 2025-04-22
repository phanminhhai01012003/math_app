import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/screen/main/about.dart';
import 'package:math_app/screen/main/advertisement.dart';
import 'package:math_app/screen/main/language.dart';
import 'package:math_app/screen/main/settings.dart';
import 'package:math_app/screen/sub/math_board/div_math_board.dart';
import 'package:math_app/screen/sub/math_board/mul_math_board.dart';
import 'package:math_app/screen/sub/practice/practice.dart';
import 'package:math_app/screen/sub/test/start_test.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                    },
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor, width: 1)
                        ),
                        child: Icon(Icons.settings,
                          color: CommonConstants.blackColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Language()));
                    },
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor, width: 1)
                        ),
                        child: Image.asset("assets/vn.png",
                          fit: BoxFit.cover,
                          width: 36,
                          height: 36,
                        )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text("Bảng tính",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: CommonConstants.blackColor
                  ),
                ),
              ),
              Center(
                child: Text("cửu chương",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: CommonConstants.blackColor
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      width: 96,
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? CommonConstants.greenColor : CommonConstants.whiteColor,
                        border: Border.all(color: selectedIndex == 0 ? CommonConstants.green2Color : CommonConstants.lightYellow2),
                        borderRadius: BorderRadius.circular(96),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("A x B",
                            style: TextStyle(
                              color: selectedIndex == 0 ? CommonConstants.whiteColor : CommonConstants.blackColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(selectedIndex == 0 ? "0%" : "", 
                            style: TextStyle(
                              color: CommonConstants.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      width: 96,
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? CommonConstants.greenColor : CommonConstants.whiteColor,
                        border: Border.all(color: selectedIndex == 1 ? CommonConstants.green2Color : CommonConstants.lightYellow2),
                        borderRadius: BorderRadius.circular(96),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("A : B",
                            style: TextStyle(
                              color: selectedIndex == 1 ? CommonConstants.whiteColor : CommonConstants.blackColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(selectedIndex == 1 ? "0%" : "", 
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
                      side: BorderSide(color: CommonConstants.brownColor, width: 1)
                    ),
                  ),
                  onPressed: () {
                    selectedIndex == 0 
                    ? Navigator.push(context, MaterialPageRoute(builder: (context) => const MulMathBoard())) 
                    : Navigator.push(context, MaterialPageRoute(builder: (context) => const DivMathBoard()));
                  },
                  child: Text("Bảng tính", 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                      side: BorderSide(color: CommonConstants.brownColor, width: 1)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Practice()));
                  },
                  child: Text("Luyện tập", 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                      side: BorderSide(color: CommonConstants.brownColor, width: 1)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StartTest()));
                  },
                  child: Text("Kiểm tra", 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                      side: BorderSide(color: CommonConstants.brownColor, width: 1)
                    ),
                  ),
                  onPressed: () {

                  },
                  child: Text("Trò chơi rèn luyện", 
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Advertisement()));
                    },
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor),
                          image: DecorationImage(
                            image: AssetImage("assets/ban.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text("ADs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: CommonConstants.blackColor
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
                    },
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor, width: 1),
                        ),
                        child: Text("?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: CommonConstants.greenColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor, width: 1),
                        ),
                        child: Icon(Icons.share,
                          color: CommonConstants.blackColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Center(
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(color: CommonConstants.brownColor, width: 1),
                        ),
                        child: Icon(Icons.thumb_up,
                          color: CommonConstants.blueColor,
                          size: 24,
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