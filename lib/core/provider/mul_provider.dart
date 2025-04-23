import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app/core/provider/settings_provider.dart';
import 'package:math_app/model/mul_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MulProvider with ChangeNotifier {
  String key = "multiplications";
  List<MulModel> _multiplications = [];
  MulModel? _curr;
  List<MulModel> get multiplications => _multiplications;
  MulModel? get curr => _curr;
  final SettingsProvider settingsProvider;
  MulProvider({required this.settingsProvider}){
    var resRangeStart = settingsProvider.settings.resRange.start;
    var resRangeEnd = settingsProvider.settings.resRange.end;
    var numRangeStart = settingsProvider.settings.numRange.start;
    var numRangeEnd = settingsProvider.settings.numRange.end;
    loadMul();
    settingsProvider.addListener(() async {
      var newResRangeStart = settingsProvider.settings.resRange.start;
      var newResRangeEnd = settingsProvider.settings.resRange.end;
      var newNumRangeStart = settingsProvider.settings.numRange.start;
      var newNumRangeEnd = settingsProvider.settings.numRange.end;
      if (resRangeStart != newResRangeStart || resRangeEnd != newResRangeEnd || numRangeStart != newNumRangeStart || numRangeEnd != newNumRangeEnd) {
        await cleanMul();
        await Future.delayed(Duration(seconds: 5));
      }
    }); 
  }
  void updateCurrMul(MulModel newMul){
    _curr = newMul;
    notifyListeners();
  }
  void genNewMul(){
    final random = Random();
    var resRangeStart = settingsProvider.settings.resRange.start;
    var resRangeEnd = settingsProvider.settings.resRange.end;
    var numRangeEnd = settingsProvider.settings.numRange.end;
    int n1 = random.nextInt(numRangeEnd.toInt())+1;
    int n2 = random.nextInt(numRangeEnd.toInt())+1;
    int res = n1*n2;
    while(res<resRangeStart || res>resRangeEnd){
      n1 = random.nextInt(numRangeEnd.toInt())+1;
      n2 = random.nextInt(numRangeEnd.toInt())+1;
      res = n1*n2;
    }
    _curr = MulModel(num1: n1, num2: n2, res: res, star: 0);
    notifyListeners();
  }
  Future<void> loadMul() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? mulEncode = _sharedPreferences.getStringList(key);
    if (mulEncode != null) {
      _multiplications = mulEncode.map((e) => MulModel.fromJson(e)).toList();
    } else{
      genMulQuestion(300);
    }
  }
  Future<void> saveMul() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? mulEncode = _multiplications.map((mul) => json.encode(mul.toJson())).toList();
    await _sharedPreferences.setStringList(key, mulEncode);
    notifyListeners();
  }
  Future<void> genMulQuestion(int n) async {
    final random = Random();
    var resRangeStart = settingsProvider.settings.resRange.start;
    var resRangeEnd = settingsProvider.settings.resRange.end;
    var numRangeEnd = settingsProvider.settings.numRange.end;
    _multiplications.clear();
    while (_multiplications.length < n) {
      int n1 = random.nextInt(numRangeEnd.toInt())+1;
      int n2 = random.nextInt(numRangeEnd.toInt())+1;
      int res = n1*n2;
      if (res >= resRangeStart && res <= resRangeEnd) {
        _multiplications.add(MulModel(num1: n1, num2: n2, res: res, star: 0));
      }
    }
    saveMul();
    notifyListeners();
  }
  Future<void> cleanMul() async{
    _multiplications.clear();
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.remove(key);
    notifyListeners();
  }
}