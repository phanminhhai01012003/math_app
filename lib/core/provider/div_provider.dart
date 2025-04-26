import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/answer_record.dart';
import 'package:math_app/model/div_model.dart';
import 'package:math_app/model/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DivProvider extends ChangeNotifier {
  String key = "division";
  List<DivModel> _division = [];
  List<DivModel> get div => _division;
  DivModel? _curr;
  DivModel? get curr => _curr;
  SettingsProvider settingsProvider;
  late SettingsModel settingsModel;
  final List<AnswerRecord> _answerHistory = [];
  final List<AnswerRecord> _currSessions = [];
  List<DivModel> _practices = [];
  int practiceidx = 0;
  int get currpracticeIdx => practiceidx;
  int _correctCount = 0;
  int get correctCount => _correctCount;
  int get wrongCount => _currSessions.length - correctCount;
  List<DivModel> get practices => _practices;
  List<AnswerRecord> get ansHistory => _answerHistory;
  List<AnswerRecord> get currSessions => _currSessions; 
  bool get isCompleted => _answerHistory.length >= 10;
  DivProvider({required this.settingsProvider}){
    settingsModel = settingsProvider.settings;
    settingsProvider.addListener(onSettingChanged);
    init();
  }
  Future<void> init() async {
    await loadDiv();
    if(_division.isEmpty) await genDivQuestion(100);
    startPracticeSession();
  }
  void onSettingChanged(){
    final newSettings = settingsProvider.settings;
    if(settingsModel != newSettings){
      settingsModel = newSettings;
      Future(() async{
        try{
          SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
          await _sharedPreferences.remove(key);
          _division.clear();
          _curr = null;
          genDivQuestion(50);
          startPracticeSession();
        }catch(e){
          throw Exception(e.toString());
        }
      });
    }
  }
List<DivModel> getDivisionAnswer(){
  if(_division.isEmpty) genDivQuestion(100);
  List<DivModel> temp = List.from(_division);
  temp.shuffle();
  return temp.take(10).toList();
}
  void resetPractice(){
    _practices.clear();
    practiceidx = 0;
    _currSessions.clear();
    _correctCount = 0;
    notifyListeners();
  }
  void startPracticeSession(){
    resetPractice();
    if(_division.isEmpty){
      genDivQuestion(100);
      return;
    }
    final random = Random();
    final available = List.generate(_division.length, (i)=>i);
    while(_practices.length < 10 && available.isNotEmpty) {
      final ranIdx = random.nextInt(available.length);
      final questLength = available[ranIdx];
      _practices.add(_division[questLength]);
      available.removeAt(ranIdx);
    }
    if(_practices.isNotEmpty){
      _curr = _practices[0];
    }
    notifyListeners();
  }
  Future<void> loadDiv() async{
    try{
      SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      List<String>? divEncode = _sharedPreferences.getStringList(key);
      if(divEncode != null && divEncode.isNotEmpty){
        _division = divEncode.map((e)=>DivModel.fromJson(json.decode(e))).toList();
        if(_division.isNotEmpty){
          final random = Random();
          _curr = _division[random.nextInt(_division.length)];
        }else{
          genDivQuestion(100);
        }
      }else{
        genDivQuestion(100);
      }
    }catch(e){
      genDivQuestion(10);
    }
  }
  Future<void> saveDiv() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? divEncode = _division.map((mul) => json.encode(mul.toJson())).toList();
    await _sharedPreferences.setStringList(key, divEncode);
    notifyListeners();
  }
  Future<void> genDivQuestion(int n) async{
    final random = Random();
    final resStart = settingsProvider.settings.resRange.start.toInt();
    final resEnd = settingsProvider.settings.resRange.end.toInt();
    final numStart = settingsProvider.settings.numRange.start.toInt();
    final numEnd = settingsProvider.settings.numRange.end.toInt();
    _division.clear();
    int attempts = 0;
    const maxAttempts = 1000;
    while(_division.length < n && attempts < maxAttempts){
      attempts++;
      int res = numStart + random.nextInt(numEnd-numStart+1);
      int num1 = resStart + random.nextInt(resEnd-resStart+1);
      if(res!=0 && num1 % res == 0){
        int num2 = num1~/res;
        if(num2>=numStart && num2<=numEnd){
          final div = DivModel(num1: num1, num2: num2, res: res, star: 0);
          if(!_division.contains(div)){
            _division.add(div);
          }
        }
      }
      if(_division.length % 20 == 0){
        await Future.delayed(Duration.zero);
      }
    }
    await saveDiv();
    notifyListeners();
  }
  Future<void> setRandomCurrDiv() async{
    if(_division.isEmpty){
      genDivQuestion(10);
      return;
    } else {
      final random = Random();
      int maxAttempts = 10;
      int attempts = 0;
      int newIndex = random.nextInt(_division.length);
      while(attempts < maxAttempts && 
      _division.length > 1 &&
      _curr != null &&
      _division[newIndex].num1 == _curr!.num1 &&
      _division[newIndex].num2 == _curr!.num2
      ){
        newIndex = random.nextInt(_division.length);
        attempts++;
      }
      if(_division.length > newIndex){
        _curr=_division[newIndex];
        notifyListeners();
      }
    }
  }
  void filterCorrectAnswers(){
    final corrAns = _answerHistory.where((rec)=>rec.isCorrect).toList();
    if(corrAns.isEmpty) return;
    _practices = corrAns.map((rec)=>DivModel(
      num1: rec.num1,
      num2: rec.num2,
      res: rec.res,
      star: 0
    )).toList();
    if(_practices.length > 10){
      _practices.shuffle();
      _practices = _practices.sublist(0,10);
    }
    practiceidx=0;
    _curr = _practices[0];
    _currSessions.clear();
    _correctCount = 0;
    _answerHistory.clear();
    notifyListeners();
  }
  void updateStar(bool isCorrect){
    if (_curr != null) {
      final index = _division.indexWhere(
        (m) => m.num1 == curr!.num1 && m.num2 == curr!.num2,
      );
      if (index != -1) {
        int currStar = _division[index].star;
        int newStar = isCorrect ? currStar + 1 : currStar - 1;
        newStar = newStar.clamp(0, 5);
        _division[index] = DivModel(
          num1: curr!.num1,
          num2: curr!.num2,
          res: curr!.res,
          star: newStar
        );
        _curr = _division[index];
        practiceidx++;
        notifyListeners();
      }
    }
  }
  Future<void> updateCurrDiv(DivModel currDiv) async{
    try{
      if(_division.isEmpty){
        genDivQuestion(10);
      }else{
        final random = Random();
        int maxAttempts = 0;
        int attempts = 0;
        int newIndex = random.nextInt(_division.length);
        while(attempts<maxAttempts &&
        _division.length > 1 &&
        _division[newIndex].num1 == _curr!.num1 &&
        _division[newIndex].num2 == _curr!.num2
        ){
          newIndex = random.nextInt(_division.length);
          attempts++;
        }
        if(_division.length > newIndex){
          _curr=_division[newIndex];
          notifyListeners();
        }
      }
    }catch(e){
      if(_curr==null && _division.isNotEmpty){
        _curr = _division.first;
        notifyListeners();
      }
    }
  }
  Future<void> cleanDiv() async{
    _division.clear();
    _curr = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
    notifyListeners();
  }
  int getTotalStars() => _division.fold(0, (s,d)=>s+d.star);
  int getStarCount(int n1, int n2){
    final div = _division.firstWhere(
      (d)=>d.num1==n1 && d.num2==n2,
      orElse: () => DivModel(num1: n1, num2: n2, res: n1~/n2, star: 0)
    );
    return div.star;
  }
  Future<void> recordAnswer(int selected) async{
    if(_curr == null) return;
    final bool isCorrect = selected == _curr!.res;
    final ansRecord = AnswerRecord(
      num1: _curr!.num1, 
      num2: _curr!.num2, 
      res: _curr!.res, 
      selected: selected, 
      isCorrect: isCorrect,
      star: _curr!.star
    );
    _answerHistory.add(ansRecord);
    _currSessions.add(ansRecord);
  }
  int sumStar(List<DivModel> list) => list.fold(0,(prev,div)=>prev+div.star);
}