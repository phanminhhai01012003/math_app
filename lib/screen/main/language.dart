import 'package:flutter/material.dart';
import 'package:math_app/common/common_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Language extends StatefulWidget {
  final Function(Locale) onLocalChanged;
  const Language({super.key, required this.onLocalChanged});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  var vnFlag = "assets/vn.png";
  var enFlag = "assets/en.png";
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final currentLocal = Localizations.localeOf(context);
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
                child: Icon(Icons.arrow_back,
                  color: CommonConstants.blackColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        title: Text(local.language,
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
            Row(
              children: [
                LanguageTile(
                  flag: vnFlag,
                  title: "Tiếng Việt",
                  onTap: () => widget.onLocalChanged(Locale("vi")),
                  selected: currentLocal.languageCode == 'vi',
                ),
                SizedBox(width: 10),
                LanguageTile(
                  flag: enFlag,
                  title: "English",
                  onTap: () => widget.onLocalChanged(Locale("en")),
                  selected: currentLocal.languageCode == 'en',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class LanguageTile extends StatelessWidget {
  final String flag;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  const LanguageTile({required this.flag, required this.title, required this.onTap, required this.selected});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: selected ? CommonConstants.yellowColor : CommonConstants.whiteColor,
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
              Image.asset(flag,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              SizedBox(height: 20),
              Text(title,
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
  }
}