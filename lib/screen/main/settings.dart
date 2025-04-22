import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  border:
                      Border.all(color: CommonConstants.brownColor, width: 1),
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
          centerTitle: true,
          title: Text(
            local.settings,
            style: TextStyle(
                color: CommonConstants.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            final settings = settingsProvider.settings;
            bool isActive = settings.isMul;
            bool isChecked1 = settings.checkAns;
            bool isChecked2 = settings.checkAns;
            bool isChecked3 = settings.showBlocks;
            return SingleChildScrollView(
              child: Column(
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
                                Text(
                                  local.mode,
                                  style: TextStyle(
                                      color: CommonConstants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isActive = isActive;
                                    });
                                    settingsProvider.updateMode(isActive);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: isActive
                                            ? CommonConstants.yellowColor
                                            : CommonConstants.whiteColor,
                                        border: Border.all(
                                            color: CommonConstants.brownColor)),
                                    child: Text(
                                      "A x B = ?",
                                      style: TextStyle(
                                          color: isActive
                                              ? CommonConstants.blackColor
                                              : CommonConstants.lightBrown,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isActive = !isActive;
                                    });
                                    settingsProvider.updateMode(isActive);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: isActive
                                            ? CommonConstants.yellowColor
                                            : CommonConstants.whiteColor,
                                        border: Border.all(
                                            color: CommonConstants.brownColor)),
                                    child: Text(
                                      "A : B = ?",
                                      style: TextStyle(
                                          color: isActive
                                              ? CommonConstants.blackColor
                                              : CommonConstants.lightBrown,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
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
                                Text(
                                  local.resRange,
                                  style: TextStyle(
                                      color: CommonConstants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
                                    Text(
                                      local.from,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 86,
                                      height: 40,
                                      child: TextField(
                                        enabled: isChecked1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: CommonConstants
                                                        .brownColor),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            filled: true,
                                            fillColor:
                                                CommonConstants.whiteColor),
                                        keyboardType: TextInputType.numberWithOptions(
                                          decimal: false,
                                          signed: false
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      local.to,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 86,
                                      height: 40,
                                      child: TextField(
                                          enabled: isChecked1,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: CommonConstants
                                                        .brownColor),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            filled: true,
                                            fillColor:
                                                CommonConstants.whiteColor,
                                          ),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.numberWithOptions(
                                            signed: false,
                                            decimal: false
                                          )),
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
                                Text(
                                  local.numRange,
                                  style: TextStyle(
                                      color: CommonConstants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      local.from,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 86,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: CommonConstants
                                                        .brownColor),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            filled: true,
                                            fillColor:
                                                CommonConstants.whiteColor),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      local.to,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 86,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: CommonConstants
                                                        .brownColor),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            filled: true,
                                            fillColor:
                                                CommonConstants.whiteColor),
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
                                Text(
                                  local.enter,
                                  style: TextStyle(
                                      color: CommonConstants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
                                        settingsProvider.updateCheck(isChecked2);
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      local.test,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      local.pracFrom,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 86,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: CommonConstants
                                                        .brownColor),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            filled: true,
                                            fillColor:
                                                CommonConstants.whiteColor),
                                        keyboardType: TextInputType.numberWithOptions(
                                          signed: false,
                                          decimal: false
                                        ),
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
                                    Text(
                                      local.showBlocks,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    Checkbox(
                                      value: isChecked3,
                                      activeColor: CommonConstants.yellowColor,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked3 = newValue!;
                                        });
                                        settingsProvider.updateBlocks(isChecked3);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      local.answerTime,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 64,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: CommonConstants
                                                      .brownColor),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          filled: true,
                                          fillColor: CommonConstants.whiteColor,
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      local.sec,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
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
                                        border: Border.all(
                                            color: CommonConstants.brownColor)),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: CommonConstants.blackColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    local.reset,
                                    style: TextStyle(
                                        color: CommonConstants.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  local.pripro,
                                  style: TextStyle(
                                      color: CommonConstants.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                      decorationColor:
                                          CommonConstants.blackColor),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
