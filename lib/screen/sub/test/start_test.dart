import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/screen/sub/test/test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartTest extends StatefulWidget {
  const StartTest({super.key});

  @override
  State<StartTest> createState() => _StartTestState();
}

class _StartTestState extends State<StartTest> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
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
              child: Icon(
                Icons.arrow_back,
                color: CommonConstants.blackColor,
                size: 30,
              ),
            ),
          ),
        ),
        title: Text(
          local.test,
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
          Center(
            child: Image.asset(
              "assets/study.png",
              fit: BoxFit.cover,
              width: 273,
              height: 344,
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                local.testbody1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: CommonConstants.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              local.testbody2,
              style: TextStyle(
                  color: CommonConstants.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonConstants.yellowColor,
                  foregroundColor: CommonConstants.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: CommonConstants.brownColor, width: 1)
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Test()));
                },
                child: Text(
                  local.ready,
                  style: TextStyle(
                      color: CommonConstants.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
