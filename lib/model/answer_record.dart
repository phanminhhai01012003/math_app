class AnswerRecord {
  int num1;
  int num2;
  int res; 
  int selected; 
  final bool isCorrect;
  AnswerRecord({
    required this.num1,
    required this.num2,
    required this.res,
    required this.selected,
    required this.isCorrect,
  });
}