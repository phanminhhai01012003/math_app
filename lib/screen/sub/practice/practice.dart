import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List<String> dotImages = [
    "assets/dot/dot1.png",
    "assets/dot/dot2.png",
    "assets/dot/dot3.png",
    "assets/dot/dot4.png",
    "assets/dot/dot5.png",
    "assets/dot/dot6.png",
    "assets/dot/dot7.png",
    "assets/dot/dot8.png",
    "assets/dot/dot9.png",
    "assets/dot/dot10.png",
  ];
  List<int> ans = [6,8,18,5];
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
        title: Text("Bài học",
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          Text("1/10",
            style: TextStyle(
              color: CommonConstants.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Divider(color: CommonConstants.brownColor, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CommonConstants.lightYellow,
                borderRadius: BorderRadius.circular(14),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5
                ),
                shrinkWrap: true,
                itemCount: dotImages.length,
                itemBuilder: (context, index) {
                  return Image.asset(dotImages[index],
                    fit: BoxFit.cover,
                    width: 37,
                    height: 37,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CommonConstants.lightYellow,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        for (int i=1; i<=5; i++) ...[
                          Icon(Icons.star,
                            size: 18,
                            color: CommonConstants.starColor,
                          )
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      children: [
                        Text("1 x 6 = ",
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 47,
                            height: 47,
                            decoration: BoxDecoration(
                              color: CommonConstants.whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: CommonConstants.brownColor, width: 1),
                            ),
                            child: Text("?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: CommonConstants.brownColor
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5
              ),
              shrinkWrap: true,
              itemCount: ans.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: CommonConstants.brownColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("${ans[index]}",
                    style: TextStyle(
                      color: CommonConstants.blackColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}