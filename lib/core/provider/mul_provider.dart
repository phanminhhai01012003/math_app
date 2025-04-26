import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/answer_record.dart';
import 'package:math_app/model/mul_model.dart';
import 'package:math_app/model/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MulProvider with ChangeNotifier {
  String key = "multiplications";
  List<MulModel> _multiplications = [];
  MulModel? _curr;
  List<MulModel> get multiplications => _multiplications;
  MulModel? get curr => _curr;
  SettingsProvider settingsProvider;
  SettingsModel settingsModel;
  List<MulModel> _practices = [];
  List<AnswerRecord> _answerHistory = [];
  List<AnswerRecord> get ansHistory => _answerHistory;
  List<AnswerRecord> _currSessions = [];
  List<AnswerRecord> get currSession => _currSessions;
  List<MulModel> get practice => _practices;
  int practiceidx = 0;
  int get currpracticeIdx => practiceidx;
  bool get isCompleted => _answerHistory.length >= 10;
  int _correctCount = 0;
  int get correctCount => _correctCount;
  int get wrongCount => _currSessions.length - correctCount;
  MulProvider({required this.settingsProvider}) : settingsModel = settingsProvider.settings {
    settingsProvider.addListener(onSettingChanged);
    loadMul();
  }
  List<MulModel> getMultiAnswer(){
    if(_multiplications.isEmpty) genMulQuestion(100);
    List<MulModel> temp = List.from(_multiplications);
    temp.shuffle();
    return temp.take(10).toList();
  }
  void listOfNumber(int num, List<MulModel> list){
    list = List.generate(12, (index){
      return list.firstWhere(
        (e) => e.num1 == num && e.num2 == index && e.star == 0, 
        orElse: () => MulModel(
          num1: num,
          num2: index,
          res: num * index,
          star: 0,
        ));
    });
    notifyListeners();
  }
  void resetPractice(){
    _practices.clear();
    practiceidx=0;
    _answerHistory.clear();
    notifyListeners();
  }
  void setRandomCurrMul() {
    if (_multiplications.isNotEmpty) {
      final random = Random();
      _curr = _multiplications[random.nextInt(_multiplications.length)];
      notifyListeners();
    } else {
      genMulQuestion(100);
    }
  }
  Future<void> updateCurrMul(MulModel newMul) async{
    try{
      if(_multiplications.isEmpty){
        genMulQuestion(10);
      }
      if(_multiplications.isNotEmpty){
        final random = Random();
        int maxAttempts = 10;
        int attempts = 0;
        var newIndex = random.nextInt(_multiplications.length);
        while(attempts < maxAttempts && _multiplications.length > 1 && 
        (_multiplications[newIndex].num1 == _curr?.num1 && _multiplications[newIndex].num2 == _curr?.num2)){
          newIndex = random.nextInt(_multiplications.length);
          attempts++;
          if(attempts % 5 == 0){
            await Future.delayed(Duration.zero);
          }
        }
        if(_multiplications.length > newIndex){
          _curr = _multiplications[newIndex];
          notifyListeners();
        }
      }
    }catch(e){
      if(_curr == null && _multiplications.isNotEmpty){
        _curr = _multiplications.first;
        notifyListeners();
      }
    }
  }
  void onSettingChanged(){
    settingsModel = settingsProvider.settings;
    resetPractice();
    Future(() async{
      try{
        SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
        await _sharedPreferences.remove(key);
        _multiplications.clear();
        await genMulQuestionsAsync(100);
        setRandomCurrMul();
        startPracticeSession();
      }catch(e){
        throw Exception(e.toString());
      }
    });
  }
  void startPracticeSession(){
    resetPractice();
    if(_multiplications.isEmpty) genMulQuestion(100);
    final random = Random();
    final available = List.generate(_multiplications.length, (i)=>i);
    while(_practices.length < 10 && available.isNotEmpty) {
      final ranIdx = random.nextInt(available.length);
      final questLength = available[ranIdx];
      _practices.add(_multiplications[questLength]);
      available.removeAt(ranIdx);
    }
    if(_practices.isNotEmpty){
      _curr = _practices[0];
    }
    notifyListeners();
  }
  Future<void> genMulQuestionsAsync(int n) async {
    final random = Random();
    final resStart = settingsModel.resRange.start.toInt();
    final resEnd = settingsModel.resRange.end.toInt();
    final numStart = settingsModel.numRange.start.toInt();
    final numEnd = settingsModel.numRange.end.toInt();
    List<MulModel> newList = [];
    int attempts = 0;
    const maxAttempts = 500;
    while (newList.length < n && attempts < maxAttempts) {
      attempts++;
      int num1 = numStart + random.nextInt(numEnd - numStart + 1);
      int num2 = numStart + random.nextInt(numEnd - numStart + 1);
      int res = num1 * num2;
      if (res >= resStart && res <= resEnd) {
        final multiplication = MulModel(
          num1: num1,
          num2: num2,
          res: res,
          star: 0,
        );
        if (!newList.contains(multiplication)) {
          newList.add(multiplication);
        }
      }
      if (newList.length % 20 == 0) {
        await Future.delayed(Duration.zero);
      }
    }
    _multiplications = newList;
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String> mulEncode = _multiplications.map((multiplication) => json.encode(multiplication.toJson())).toList();
    await _sharedPreferences.setStringList(key, mulEncode);
    await _sharedPreferences.setInt('resRangeStart', resStart);
    await _sharedPreferences.setInt('resRangeEnd', resEnd);
    await _sharedPreferences.setInt('numRangeStart', numStart);
    await _sharedPreferences.setInt('numbRangeEnd', numEnd);
    notifyListeners();
  }
  Future<void> loadMul() async {
    try{
      SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
      final currResStart = settingsModel.resRange.start.toInt();
      final currResEnd = settingsModel.resRange.end.toInt();
      final currNumStart = settingsModel.numRange.start.toInt();
      final currNumEnd = settingsModel.numRange.end.toInt();
      final saveResStart = _sharedPreferences.getInt('resRangeStart') ?? -1;
      final saveResEnd = _sharedPreferences.getInt('resRangeEnd') ?? -1;
      final saveNumStart = _sharedPreferences.getInt('resNumStart') ?? -1;
      final saveNumEnd = _sharedPreferences.getInt('resNumEnd') ?? -1;
      final changed =
          saveResStart != currResStart ||
          saveResEnd != currResEnd ||
          saveNumStart != currNumStart ||
          saveNumEnd != currNumEnd;
      await Future(() async{
        if(changed){
          await _sharedPreferences.setInt("resRangeStart", currResStart);
          await _sharedPreferences.setInt("resRangeEnd", currResEnd);
          await _sharedPreferences.setInt("numRangeStart", currNumStart);
          await _sharedPreferences.setInt("numRangeEnd", currNumEnd);
          await genMulQuestionsAsync(100);
        }else{
          List<String>? mulEncode = _sharedPreferences.getStringList(key);
          if(mulEncode != null && mulEncode.isNotEmpty){
            _multiplications = mulEncode.map((e) => MulModel.fromJson(json.encode(e))).toList();
          }else{
            await genMulQuestionsAsync(100);
          }
        }
        setRandomCurrMul();
        startPracticeSession();
        notifyListeners();
      });
    }catch(e){
      throw Exception(e.toString());
    }
  }
  Future<void> saveMul() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? mulEncode = _multiplications.map((mul) => json.encode(mul.toJson())).toList();
    await _sharedPreferences.setStringList(key, mulEncode);
    notifyListeners();
  }
  void updateStar(bool isCorrect) {
    if (_curr != null) {
      final index = _multiplications.indexWhere(
        (m) => m.num1 == curr!.num1 && m.num2 == curr!.num2,
      );
      if (index != -1) {
        int currStar = _multiplications[index].star;
        int newStar = isCorrect ? currStar + 1 : currStar - 1;
        newStar = newStar.clamp(0, 5);
        _multiplications[index] = MulModel(
          num1: curr!.num1,
          num2: curr!.num2,
          res: curr!.res,
          star: newStar
        );
        _curr = _multiplications[index];
      }
    }
  }
  Future<void> genMulQuestion(int n) async {
    final random = Random();
    var resRangeStart = settingsProvider.settings.resRange.start.toInt();
    var resRangeEnd = settingsProvider.settings.resRange.end.toInt();
    var numRangeStart = settingsProvider.settings.numRange.start.toInt();
    var numRangeEnd = settingsProvider.settings.numRange.end.toInt();
    int attempts = 0;
    const maxAttempts = 500;
    _multiplications.clear();
    while (_multiplications.length < n && attempts < maxAttempts) {
      attempts++;
      int n1 = numRangeStart + random.nextInt(numRangeEnd-numRangeStart+1);
      int n2 = numRangeStart + random.nextInt(numRangeEnd-numRangeStart+1);
      int res = n1*n2;
      if (res >= resRangeStart && res <= resRangeEnd) {
        _multiplications.add(MulModel(num1: n1, num2: n2, res: res, star: 0));
      }
    }
    saveMul();
    notifyListeners();
  }
  void filterCorrectAnswers(){
    final corrAns = _answerHistory.where((rec)=>rec.isCorrect).toList();
    if(corrAns.isEmpty) return;
    _practices = corrAns.map((rec)=>MulModel(
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
  Future<void> recordAnswer(bool isCorrect, int selected) async{
    if(_curr==null) return;
    final answerRec = AnswerRecord(
      num1: _curr!.num1, 
      num2: _curr!.num2, 
      res: _curr!.res, 
      selected: selected, 
      isCorrect: isCorrect,
      star: _curr!.star,
    );
    _answerHistory.add(answerRec);
    _currSessions.add(answerRec);
    if(isCorrect){
      _correctCount++;
      updateStar(true);
      await Future.delayed(Duration(seconds: 2));
      if(!isCompleted){
        if(practiceidx < _practices.length-1){
          practiceidx++;
          _curr = _practices[practiceidx];
        }else{
          startPracticeSession();
        }
      }else{
        updateStar(false);
      }
    }
    notifyListeners();
  }
  int sumStar(List<MulModel> list) => list.fold(0, (prev, mul) => prev+mul.star);
  void retrySession(){
    if(_currSessions.isEmpty) return;
    _practices = _currSessions.map((r) => MulModel(
      num1: r.num1, 
      num2: r.num2, 
      res: r.res
    )).toList();
    practiceidx=0;
    _curr=_practices[0];
  }
  int get correctAnswer => _answerHistory.where((r) => r.isCorrect).length;
  int get inCorrectAnswer => _answerHistory.where((r) => !r.isCorrect).length;
}