import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_app/model/div_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DivProvider extends ChangeNotifier {
  String key = "Division";
  List<DivModel> _division = [];
  List<DivModel> get div => _division;
  DivModel? _curr;
  DivModel? get curr => _curr;
  DivProvider(){
    loadDiv();
  }
  Future<void> loadDiv() async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? divEncode = _sharedPreferences.getStringList(key);
    if (divEncode != null){
      _division = divEncode.map((e) => DivModel.fromJson(e)).toList();
    }
    notifyListeners();
  }
  Future<void> saveDiv() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<String>? divEncode = _division.map((mul) => json.encode(mul.toJson())).toList();
    await _sharedPreferences.setStringList(key, divEncode);
    notifyListeners();
  }
  void genDivQuestion() {
    final random = Random();
    int n1 = random.nextInt(9)+1;
    int n2 = random.nextInt(9)+1;
    int res = n1~/n2;
    _curr = DivModel(num1: n1, num2: n2, res: res);
    notifyListeners();
  }
  void updateStar(bool isCorrect){
    if(_curr!=null){
      if(isCorrect){
        if(_curr!.star<5) _curr!.star++;
      }else{
        if(_curr!.star>0) _curr!.star--;
      }
    }
  }
  void addNewDiv(DivModel div){
    if(!_division.contains(div)){
      _division.add(div);
      saveDiv();
    }
  }
  List<int> showAnswer() {
    final random = Random();
    if(_curr==null) return [];
    List<int> answerList = [_curr!.res];
    while(answerList.length<4){
      int incorrectAnswer = random.nextInt(10);
      if(!answerList.contains(incorrectAnswer)){
        answerList.add(incorrectAnswer);
      }
    }
    answerList.shuffle();
    return answerList;
  }
}