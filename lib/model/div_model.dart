import 'dart:convert';

class DivModel {
  int num1;
  int num2;
  int res;
  int star;
  DivModel({
    required this.num1,
    required this.num2,
    required this.res,
    this.star = 0
  });
  Map<String, dynamic> toMap(){
    return {
      "num1": num1,
      "num2": num2,
      "res": res,
      "star": star
    };
  }
  factory DivModel.fromMap(Map<String, dynamic> map){
    return DivModel(
      num1: map["num1"],
      num2: map["num2"],
      res: map["res"],
      star: map["star"]
    );
  }
  String toJson() => json.encode(toMap());
  factory DivModel.fromJson(String s) => DivModel.fromMap(json.decode(s));
}