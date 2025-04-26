import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/dialog.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CustomDialog custom = CustomDialog();
  @override
  void dispose(){
    super.dispose();
  }
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
            bool isChecked1 = settings.checkNumRange;
            bool isChecked2 = settings.checkAns;
            bool isChecked3 = settings.showBlocks;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: CommonConstants.brownColor, thickness: 2),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 28.h),
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
                                mode("A x B = ?", 
                                isActive: isActive, 
                                onTap: () => settingsProvider.updateMode(true)),
                                mode("A : B = ?",
                                isActive: !isActive, 
                                onTap: () => settingsProvider.updateMode(false))
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
                                    checkBox(isChecked1, onChanged: (value) => settingsProvider.updateCheckNumRange(value!)),
                                    SizedBox(width: 10),
                                    Text(
                                      local.from,
                                      style: TextStyle(
                                          color: CommonConstants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10),
                                    inputBox(
                                      settings.resRange.start.toString(),
                                      enabled: settings.checkNumRange,
                                      onChanged: (value) {
                                        settingsProvider.updateResultRange(
                                          RangeValues(
                                            (int.tryParse(value) ?? 1).toDouble(),
                                            settings.resRange.end
                                          ),
                                        );
                                      }
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
                                    inputBox(
                                      settings.resRange.end.toString(),
                                      enabled: settings.checkNumRange,
                                      onChanged: (value){
                                        settingsProvider.updateResultRange(
                                          RangeValues(
                                            settings.resRange.start,
                                            (int.tryParse(value) ?? 90000).toDouble()
                                          )
                                        );
                                      }
                                    )
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
                                    inputBox(
                                      settings.numRange.start.toString(),
                                      onChanged: (value){
                                        settingsProvider.updateNumberRange(
                                          RangeValues(
                                            (int.tryParse(value) ?? 1).toDouble(),
                                            settings.numRange.end,
                                          )
                                        );
                                      }
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
                                    inputBox(
                                      settings.numRange.end.toString(),
                                      onChanged: (value){
                                        settingsProvider.updateNumberRange(
                                          RangeValues(
                                            settings.numRange.start,
                                            (int.tryParse(value) ?? 90000).toDouble()
                                          ),
                                        );
                                      }
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
                                    checkBox(
                                      isChecked2,
                                      onChanged: (value) => settingsProvider.updateCheck(value!)
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
                                    inputBox(
                                      settings.practicePercentage.toString(),
                                      onChanged: (value) => settingsProvider.updatePracticePercentage((int.tryParse(value) ?? 20).toDouble())
                                    )
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
                                    checkBox(isChecked3, onChanged: (value) => settingsProvider.updateBlocks(value!))
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
                                    inputBox(
                                      settings.answerTime.toString(),
                                      onChanged: (value) => settingsProvider.updateAnswerTime(int.tryParse(value) ?? 15)
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
                                  GestureDetector(
                                    onTap: () {
                                      custom.resetProgressDialog(context, (){
                                        settingsProvider.reset();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
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
                ],
              ),
            );
          },
        ));
  }
  Widget mode(String text, {
    bool isActive = false,
    VoidCallback? onTap,
    final double height = 40,
    final double width = 100,
  }){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? CommonConstants.yellowColor : CommonConstants.whiteColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: CommonConstants.brownColor),
          boxShadow: isActive ? [BoxShadow(
            color: CommonConstants.blackColor,
            offset: Offset(0, 2),
            blurRadius: 5
          )] : null
        ),
        child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? CommonConstants.blackColor : CommonConstants.greyColor
          ),
        ),
      ),
    );
  }
  Widget checkBox(bool isChecked, {ValueChanged<bool?>? onChanged}){
    return Checkbox(
      value: isChecked,
      onChanged: onChanged,
      activeColor: CommonConstants.darkyellowColor,
    );
  }
  Widget inputBox(String val, {String? suffix, ValueChanged<String>? onChanged, bool? enabled}){
    return Container(
      width: 86.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: CommonConstants.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: CommonConstants.brownColor)
      ),
      child: Center(
        child: TextFormField(
          enabled: enabled,
          initialValue: val,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            isDense: true,
            suffixText: suffix,
            border: InputBorder.none,
            suffixStyle: TextStyle(fontSize: 14.sp)
          ),
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
        ),
      ),
    );
  }
}