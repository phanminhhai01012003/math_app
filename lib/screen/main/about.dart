import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class About extends StatelessWidget {
  const About({super.key});

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
        title: Text("Thông tin ứng dụng",
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: CommonConstants.brownColor,
            thickness: 2,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et." 
              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim." 
              "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et." 
              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim." 
              "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et." 
              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim." 
              "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et." 
              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim." 
              "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et." 
              "Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim." 
              "Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
              style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      )
    );
  }
}