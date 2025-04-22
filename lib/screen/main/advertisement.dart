import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: CommonConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: CommonConstants.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(12),
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
                child: Icon(
                  Icons.arrow_back,
                  color: CommonConstants.blackColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        title: Text(local.adTitle,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {

            },
            child: Text(local.restore,
              style: TextStyle(
                color: CommonConstants.brownColor,
                fontSize: 13,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Divider(color: CommonConstants.brownColor, thickness: 1),
          SizedBox(height: 20),
          Center(
            child: Image.asset("assets/noads.png",
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(local.plan,
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: selectedIndex == 0 ? CommonConstants.brownColor : CommonConstants.yellowColor),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? CommonConstants.yellowColor : CommonConstants.whiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        border: Border.all(color: selectedIndex == 0 ? CommonConstants.brownColor : CommonConstants.yellowColor)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                            size: 18,
                            color: selectedIndex == 0 ? CommonConstants.blackColor : CommonConstants.brownColor,
                          ),
                          SizedBox(width: 10),
                          Text(local.forever,
                            style: TextStyle(
                              color: selectedIndex == 0 ? CommonConstants.blackColor : CommonConstants.brownColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(r"5$",
                        style: TextStyle(
                          color: CommonConstants.blackColor,
                          fontSize: 48,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: CommonConstants.lightGreenColor,
                          borderRadius: BorderRadius.circular(19)
                        ),
                        child: Text(local.popular,
                          style: TextStyle(
                            color: CommonConstants.greenColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(local.pay,
                        style: TextStyle(
                          color: CommonConstants.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: selectedIndex == 1 ? CommonConstants.brownColor : CommonConstants.yellowColor),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? CommonConstants.yellowColor : CommonConstants.whiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        border: Border.all(color: selectedIndex == 1 ? CommonConstants.brownColor : CommonConstants.yellowColor)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.play_circle_outline,
                            size: 18,
                            color: selectedIndex == 1 ? CommonConstants.blackColor : CommonConstants.brownColor,
                          ),
                          SizedBox(width: 10),
                          Text(local.daily,
                            style: TextStyle(
                              color: selectedIndex == 1 ? CommonConstants.blackColor : CommonConstants.brownColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(local.adDisable,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonConstants.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonConstants.yellowColor,
                  foregroundColor: CommonConstants.blackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: CommonConstants.brownColor)
                  ),
                ),
                onPressed: () {
                  
                },
                child: Text(local.cont,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}