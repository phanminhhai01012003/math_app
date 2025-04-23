import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:math_app/common/common_constants.dart';
class TestQList extends StatefulWidget {
  const TestQList({super.key});

  @override
  State<TestQList> createState() => _TestQListState();
}

class _TestQListState extends State<TestQList> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
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
        title: Text(local.qList,
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
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: CommonConstants.lightYellow2,
                  offset: Offset(0, 5)
                )
              ],
            ),
            child: Column(
              children: List.generate(10, (index){
                return Row(
                  children: [
                    Icon(Icons.check,
                      size: 30,
                      color: CommonConstants.green2Color,
                    ),
                    SizedBox(width: 20),
                    Text("3 x 1 = 3",
                      style: TextStyle(
                        color: CommonConstants.green2Color,
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}