import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/common/custom_star.dart';
import 'package:math_app/common/dialog.dart';
import 'package:math_app/core/provider/div_provider.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/div_model.dart';
import 'package:math_app/model/mul_model.dart';
import 'package:math_app/screen/sub/completed/result.dart';
import 'package:math_app/screen/sub/practice/practice_div.dart';
import 'package:math_app/screen/sub/practice/practice_mul.dart';
import 'package:provider/provider.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      if(!mounted) return;
      try{
        final mulProvider = Provider.of<MulProvider>(context, listen: false);
        mulProvider.onSettingChanged();
      }catch(e){
        throw Exception(e.toString());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final settings = settingsProvider.settings;
    bool isMul = settings.isMul;
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
        title: Text(local.practice,
          style: TextStyle(
            color: CommonConstants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: isMul ? PracticeMul() : PracticeDiv(),
    );
  }
}
class DotImages extends StatelessWidget {
  final List<String> dotImages;
  const DotImages({super.key, required this.dotImages});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CommonConstants.lightYellow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
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
        )
      ),
    );
  }
}
class DataScreen extends StatelessWidget {
  final bool showStar;
  final int num1;
  final int num2;
  const DataScreen({super.key, this.showStar = true, required this.num1, required this.num2});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    bool isMul = settingsProvider.settings.isMul;
    return Container(
      height: 127.h,
      width: 343.w,
      decoration: BoxDecoration(
        color: CommonConstants.lightYellow,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<MulProvider, int>(
              builder: (context, val, child) => CustomStar(), 
              selector: (p0, p1)=>p1.curr!.star
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isMul ? Text("$num1 x $num2 = ",
                  style: TextStyle(
                    color: CommonConstants.blackColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600
                  ),
                ) : Text("$num1 : $num2",
                  style: TextStyle(
                    color: CommonConstants.blackColor,
                    fontSize: 24.sp,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class ChooseResultMul extends StatefulWidget {
  final MulModel? currMul;
  final Function showNext;
  const ChooseResultMul({super.key, required this.currMul, required this.showNext});

  @override
  State<ChooseResultMul> createState() => _ChooseResultMulState();
}

class _ChooseResultMulState extends State<ChooseResultMul> {
  List<int> resList = [];
  Set<int> wrongAnswers = {};
  int? selectedAnswer;
  bool? isCorrectAnswer;
  bool isProcessing = false;
  final random = Random();
  CustomDialog dialog = CustomDialog();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genAnsOptions();
  }
  @override
  void didUpdateWidget(covariant ChooseResultMul oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.currMul != oldWidget.currMul){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        wrongAnswers.clear();
        isProcessing=false;
      });
      _genAnsOptions();
    }
  }
  void _genAnsOptions(){
    if(widget.currMul==null) return;
    resList.clear();
    resList.add(widget.currMul!.res);
    final int correctRes = widget.currMul!.res;
    final int minRange = max(1, (correctRes*0.8).toInt());
    final int maxRange = max(minRange+10, (correctRes*1.2).toInt());
    while(resList.length < 4){
      int wrongAnswers = minRange+random.nextInt(maxRange-minRange);
      if(wrongAnswers!=correctRes && !resList.contains(wrongAnswers)){
        resList.add(wrongAnswers);
      }
    }
    resList.shuffle();
  }
  Future<void> handleAnswer(int selected) async{
    if(widget.currMul == null || isProcessing) return;
    setState(() {
      isProcessing = true;
      selectedAnswer = selected;
    });
    final bool isCorrect = selected == widget.currMul!.res;
    final multiProvider = Provider.of<MulProvider>(context, listen: false);
    setState(() {
      isCorrectAnswer = isCorrect;
      if(!isCorrect) wrongAnswers.add(selected); 
    });
    await multiProvider.recordAnswer(isCorrect, selected);
    if(isCorrect) {
      await Future.delayed(Duration(seconds: 1));
      if(!mounted) return;
      if(multiProvider.isCompleted){
        final settings = Provider.of<SettingsProvider>(context, listen: false);
        settings.updateProcess(true,
        (multiProvider.sumStar(multiProvider.multiplications) ~/ 144 * 100)
        );
        dialog.showFinishPracticeDialog(context, (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Result(
              correctCount: multiProvider.correctCount,
              wrongCount: multiProvider.wrongCount,
              total: 10,
              stars: multiProvider.correctCount >= 8 ? 3 : multiProvider.correctCount >= 5 ? 2 : 1,
            ))
          );
        });
      }
    } else{
      await Future.delayed(Duration(milliseconds: 500));
    }
    if(mounted){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        isProcessing=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.5,
            children: resList.map((a){
              bool isWrong = wrongAnswers.contains(a);
              bool isSelected = selectedAnswer == a;
              bool isCorrect = a==widget.currMul?.res;
              Color bgColor = CommonConstants.whiteColor;
              if(isSelected){
                bgColor = isCorrect ? CommonConstants.greenColor : CommonConstants.redColor;
              }
              return GestureDetector(
                onTap: (!isWrong && !isProcessing) ? 
                () => handleAnswer(a) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: CommonConstants.brownColor, width: 2),
                    borderRadius: BorderRadius.circular(12.r)
                  ),
                  child: Center(
                    child: Text(a.toString(),
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
class ChooseResultDiv extends StatefulWidget {
  final DivModel currDiv;
  final Function showNext;
  const ChooseResultDiv({super.key, required this.currDiv, required this.showNext});

  @override
  State<ChooseResultDiv> createState() => _ChooseResultDivState();
}

class _ChooseResultDivState extends State<ChooseResultDiv> {
  List<int> resList = [];
  Set<int> wrongAnswers = {};
  int? selectedAnswer;
  bool? isCorrectAnswer;
  bool isProcessing = false;
  late DivModel div;
  CustomDialog dialog = CustomDialog();
  void initState() {
    // TODO: implement initState
    super.initState();
    div = widget.currDiv;
    _genAnsOptions();
  }
  @override
  void didUpdateWidget(covariant ChooseResultDiv oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.currDiv != oldWidget.currDiv){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        wrongAnswers.clear();
        isProcessing=false;
      });
      _genAnsOptions();
    }
  }
  void _genAnsOptions(){
    resList.clear();
    resList.add(div.res);
    final random = Random();
    final int correctRes = div.res;
    final int minRange = max(1, (correctRes*0.8).toInt());
    final int maxRange = max(minRange+10, (correctRes*1.2).toInt());
    while(resList.length < 4){
      int wrongAnswers = minRange+random.nextInt(maxRange-minRange);
      if(wrongAnswers!=correctRes && !resList.contains(wrongAnswers)){
        resList.add(wrongAnswers);
      }
    }
    resList.shuffle();
  }
  Future<void> handleAnswer(int selected) async{
    if(isProcessing) return;
    final bool isCorrect = selected == widget.currDiv.res;
    final divProvider = Provider.of<DivProvider>(context, listen: false);
    setState(() {
      isProcessing = true;
      selectedAnswer = selected;
      isCorrectAnswer = isCorrect;
      if(!isCorrect) wrongAnswers.add(selected); 
    });
    await divProvider.recordAnswer(selected);
    if(isCorrect) {
      await Future.delayed(Duration(seconds: 1));
      if(!mounted) return;
      if(divProvider.isCompleted){
        dialog.showFinishPracticeDialog(context, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Result(
              correctCount: divProvider.correctCount,
              wrongCount: divProvider.wrongCount,
              total: 10,
              stars: divProvider.correctCount >= 8 ? 3 : divProvider.correctCount >=5 ? 2 : 1,
            ))
          );
        });
      }
    } else{
      await Future.delayed(Duration(milliseconds: 500));
    }
    if(mounted){
      setState(() {
        selectedAnswer=null;
        isCorrectAnswer=null;
        isProcessing=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1.5,
            children: resList.map((a){
              bool isWrong = wrongAnswers.contains(a);
              bool isSelected = selectedAnswer == a;
              bool isCorrect = a==widget.currDiv.res;
              Color bgColor = CommonConstants.whiteColor;
              if(isSelected){
                bgColor = isCorrect ? CommonConstants.greenColor : CommonConstants.redColor;
              }
              return GestureDetector(
                onTap: (!isWrong && !isProcessing) ? 
                () => handleAnswer(a) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: CommonConstants.brownColor, width: 2),
                    borderRadius: BorderRadius.circular(12.r)
                  ),
                  child: Center(
                    child: Text(a.toString(),
                      style: TextStyle(
                        color: CommonConstants.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}