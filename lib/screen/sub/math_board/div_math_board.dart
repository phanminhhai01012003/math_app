import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:math_app/common/custom_star.dart';
class DivMathBoard extends StatefulWidget {
  const DivMathBoard({super.key});

  @override
  State<DivMathBoard> createState() => _DivMathBoardState();
}

class _DivMathBoardState extends State<DivMathBoard> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
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
        title: Text(local.calculate,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(color: CommonConstants.brownColor, thickness: 1),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: CommonConstants.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: CommonConstants.brownColor)
                ),
                child: CalculateAndRatingBar(),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: NumberButton(),
            ),
          ],
        ),
      )
    );
  }
  Widget CalculateAndRatingBar(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2
      ),
      shrinkWrap: true,
      itemCount: 11,
      itemBuilder: (context, index) {
        final indexNonZero = index + 1;
        final res = selectedIndex * indexNonZero;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomStar()
              ],
            ),
            SizedBox(height: 10),
            Text("${res} : ${selectedIndex} = ${indexNonZero}",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        );
      },
    );
  }
  Widget NumberButton() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      shrinkWrap: true,
      itemCount: 11,
      itemBuilder: (context, index) {
        final indexNonZero = index + 1;
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = indexNonZero;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedIndex == indexNonZero ? CommonConstants.yellowColor : CommonConstants.whiteColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: CommonConstants.brownColor)
            ),
            child: Text("${indexNonZero}",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        );
      },
    );
  }
}