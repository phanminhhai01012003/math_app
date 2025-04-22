import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isChecked1 = false, isChecked2 = false, isChecked3 = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        centerTitle: true,
        title: Text("Cài đặt",
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: CommonConstants.brownColor, thickness: 2),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Chế độ:", 
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: selectedIndex == 0 ? CommonConstants.yellowColor : CommonConstants.whiteColor,
                              border: Border.all(color: CommonConstants.brownColor)
                            ),
                            child: Text("A x B = ?",
                              style: TextStyle(
                                color: selectedIndex == 0 ? CommonConstants.blackColor : CommonConstants.lightBrown,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: selectedIndex == 1 ? CommonConstants.yellowColor : CommonConstants.whiteColor,
                              border: Border.all(color: CommonConstants.brownColor)
                            ),
                            child: Text("A : B = ?",
                              style: TextStyle(
                                color: selectedIndex == 1 ? CommonConstants.blackColor : CommonConstants.lightBrown,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Khoảng kết quả",
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked1,
                              activeColor: CommonConstants.yellowColor,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked1 = newValue!;
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Text("Từ",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 86,
                              height: 40,
                              child: TextField(
                                enabled: isChecked1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("đến",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 86,
                              height: 40,
                              child: TextField(
                                enabled: isChecked1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Khoảng số",
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Từ",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 86,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text("đến",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 86,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gõ câu trả lời",
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked2,
                              activeColor: CommonConstants.yellowColor,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked2 = newValue!;
                                });
                              },
                            ),
                            SizedBox(width: 5),
                            Text("Kiểm tra",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 20),
                            Text("Bắt đầu từ",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 86,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CommonConstants.lightYellow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Hiện khối trong khi học tập:",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 10),
                            Checkbox(
                              value: isChecked3,
                              activeColor: CommonConstants.yellowColor,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked3 = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text("Thời gian trả lời (kiểm tra):",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 64,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CommonConstants.brownColor),
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  filled: true,
                                  fillColor: CommonConstants.whiteColor,
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("giây",
                              style: TextStyle(
                                color: CommonConstants.blackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: CommonConstants.yellowColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: CommonConstants.brownColor)
                            ),
                            child: Center(
                              child: Icon(Icons.delete,
                                size: 20,
                                color: CommonConstants.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text("Xóa tiến trình",
                            style: TextStyle(
                              color: CommonConstants.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text("Chính sách bảo mật",
                          style: TextStyle(
                            color: CommonConstants.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: CommonConstants.blackColor
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}