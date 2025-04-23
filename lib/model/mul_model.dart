import 'dart:convert';

class MulModel {
  int num1;
  int num2;
  int res;
  int star;
  MulModel({
    required this.num1,
    required this.num2,
    required this.res,
    this.star = 0
  });
  MulModel copyWith({
    int? num1,
    int? num2,
    int? res,
    int? star
  }){
    return MulModel(
      num1: num1 ?? this.num1,
      num2: num2 ?? this.num2,
      res: res ?? this.res,
      star: star ?? this.star,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "num1": num1,
      "num2": num2,
      "res": res,
      "star": star
    };
  }
  factory MulModel.fromMap(Map<String, dynamic> map){
    return MulModel(
      num1: map["num1"],
      num2: map["num2"],
      res: map["res"],
      star: map["star"]
    );
  }
  String toJson() => json.encode(toMap());
  factory MulModel.fromJson(String s) => MulModel.fromMap(json.decode(s));
}