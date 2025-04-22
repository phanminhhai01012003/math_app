import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<Map<String, dynamic>> languages = [
    {
      'logo': 'assets/vn.png',
      'content': 'Tiếng Việt',
    },
    {
      'logo': 'assets/en.png',
      'content': 'English'
    }
  ];
  int selectedIndex = 0;
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
        title: Text("Ngôn ngữ",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: CommonConstants.brownColor, thickness: 2),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? CommonConstants.yellowColor : CommonConstants.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: CommonConstants.lightYellow2,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,3)
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(languages[index]['logo'],
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(height: 20),
                          Text(languages[index]['content'],
                            style: TextStyle(
                              color: CommonConstants.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}