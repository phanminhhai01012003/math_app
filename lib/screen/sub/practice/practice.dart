import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:math_app/core/provider/mul_provider.dart';
import 'package:math_app/core/provider/settings_provider.dart';
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
        title: Text(local.lesson,
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