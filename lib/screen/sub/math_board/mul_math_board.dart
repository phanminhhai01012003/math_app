import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class MulMathBoard extends StatefulWidget {
  const MulMathBoard({super.key});

  @override
  State<MulMathBoard> createState() => _MulMathBoardState();
}

class _MulMathBoardState extends State<MulMathBoard> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
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
        title: Text("Bảng tính",
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
                child: CalculateAndRatingBar(context),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: NumberButton(context),
            ),
          ],
        ),
      )
    );
  }
  Widget CalculateAndRatingBar(BuildContext context){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.2
      ),
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        final res = selectedIndex * index;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i=1; i<=5; i++) ...[
                  Icon(Icons.star,
                    size: 18,
                    color: CommonConstants.starColor,
                  )
                ],
              ],
            ),
            SizedBox(height: 10),
            Text("${selectedIndex} x ${index} = ${res}",
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
  Widget NumberButton(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedIndex == index ? CommonConstants.yellowColor : CommonConstants.whiteColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: CommonConstants.brownColor)
            ),
            child: Text("${index}",
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