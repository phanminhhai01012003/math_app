import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/screen/main/about.dart';
import 'package:math_app/screen/main/advertisement.dart';
import 'package:math_app/screen/main/language.dart';
import 'package:math_app/screen/main/settings.dart';
import 'package:math_app/screen/sub/math_board/div_math_board.dart';
import 'package:math_app/screen/sub/math_board/mul_math_board.dart';
import 'package:math_app/screen/sub/practice/practice.dart';
import 'package:math_app/screen/sub/test/start_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final settings = settingsProvider.settings;
    bool isActive = settings.isMul;
    final local = AppLocalizations.of(context)!;
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
                child: Text(local.title,
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
                  CircleProgress(
                    selected: isActive,
                    operation: "A X B",
                    percentage: "0%",
                  ),
                  CircleProgress(
                    selected: !isActive, 
                    operation: "A : B", 
                    percentage: "0%"
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
                    isActive 
                    ? Navigator.push(context, MaterialPageRoute(builder: (context) => const MulMathBoard())) 
                    : Navigator.push(context, MaterialPageRoute(builder: (context) => const DivMathBoard()));
                  },
                  child: Text(local.calculate, 
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
                  child: Text(local.practice, 
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
                  child: Text(local.test, 
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
                  child: Text(local.training, 
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
class CircleProgress extends StatelessWidget {
  bool selected;
  String operation;
  String percentage;
  CircleProgress({super.key, required this.selected, required this.operation, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool isMul = settingsProvider.settings.isMul;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 96.w,
          height: 96.h,
          child: CircularProgressIndicator(
            value: double.parse(percentage.replaceAll('%', ''))/100,
            strokeWidth: 3,
            backgroundColor: CommonConstants.greyColor,
            color: selected ? CommonConstants.greenColor : CommonConstants.lightYellow2,
          ),
        ),
        InkWell(
          onTap: () {
            settingsProvider.updateMode(isMul);
          },
          child: Container(
            width: 96.w,
            height: 96.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? CommonConstants.greenColor : CommonConstants.whiteColor,
              border: Border.all(color: selected ? CommonConstants.green2Color : CommonConstants.lightYellow2),
              borderRadius: BorderRadius.circular(96),
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