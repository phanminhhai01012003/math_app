import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:math_app/screen/main/home.dart';
import 'package:math_app/screen/sub/test/test.dart';
import 'package:math_app/screen/sub/test/test_q_list.dart';

class TestResult extends StatefulWidget {
  final int correctCount;
  final int wrongCount;
  final int total;
  const TestResult({
    super.key,
    required this.correctCount,
    required this.wrongCount,
    this.total = 10
  });
  @override
  State<TestResult> createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: GestureDetector(
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
        ),
        title: Text(local.result,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) => Container(
                alignment: Alignment.center,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: CommonConstants.greenColor,
                  borderRadius: BorderRadius.circular(48)
                ),
                child: Icon(Icons.check,
                  size: 30,
                  color: CommonConstants.whiteColor,
                ),
              )),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  height: 158,
                  decoration: BoxDecoration(
                    color: CommonConstants.greenColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: CommonConstants.green2Color)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("10",
                          style: TextStyle(
                            color: CommonConstants.whiteColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(local.correct,
                          style: TextStyle(
                            color: CommonConstants.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 158,
                  decoration: BoxDecoration(
                    color: CommonConstants.redColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: CommonConstants.red2Color)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("0",
                          style: TextStyle(
                            color: CommonConstants.whiteColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(local.incorrect,
                          style: TextStyle(
                            color: CommonConstants.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TestQList()));
                },
                child: Row(
                  children: [
                    Icon(Icons.list_alt_rounded,
                      size: 20,
                    ),
                    SizedBox(width: 22),
                    Text(local.qList, 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                },
                child: Row(
                  children: [
                    Icon(Icons.refresh_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 22),
                    Text(local.again, 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,
                      size: 20,
                    ),
                    SizedBox(width: 22),
                    Text("Menu", 
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}