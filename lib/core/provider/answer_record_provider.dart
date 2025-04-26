import 'package:flutter/material.dart';
import 'package:math_app/model/answer_record.dart';

class AnswerRecordProvider extends ChangeNotifier {
  List<AnswerRecord> listAnswer = [];
  void addAnswer({
    required int num1,
    required int num2,
    required int res,
    required bool isCorrect,
  }) {
    AnswerRecord a = AnswerRecord(
      num1: num1,
      num2: num2,
      res: res,
      selected: 0,
      isCorrect: isCorrect,
      star: 0,
    );
    listAnswer.add(a);
    notifyListeners();
  }
  void cleanAnswer() {
    listAnswer.clear();
  }
}