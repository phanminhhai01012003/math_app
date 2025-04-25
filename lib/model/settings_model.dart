import 'package:flutter/material.dart';

class SettingsModel {
  bool isMul;
  RangeValues resRange;
  RangeValues numRange;
  bool checkAns;
  bool checkNumRange;
  double practicePercentage;
  bool showBlocks;
  int answerTime;
  int processMul;
  int processDiv;
  int sumCount;
  SettingsModel({
    this.isMul = true,
    this.resRange = const RangeValues(1, 90000),
    this.numRange = const RangeValues(1, 300),
    this.checkAns = false,
    this.checkNumRange = false,
    this.practicePercentage = 20,
    this.showBlocks = true,
    this.answerTime = 15,
    this.processMul = 0,
    this.processDiv = 0,
    this.sumCount = 0
  });
  Map<String, dynamic> toJson() {
    return {
      "isMul": isMul,
      "resRangeStart": resRange.start,
      "resRangeEnd": resRange.end,
      "numRangeStart": numRange.start,
      "numRangeEnd": numRange.end, 
      "checkAns": checkAns,
      "checkNumRange": checkNumRange,
      "practicePercentage": practicePercentage,
      "showBlocks": showBlocks,
      "answerTime": answerTime,
      "processMul": processMul,
      "processDiv": processDiv,
      "sumCount": sumCount
    };
  }
  factory SettingsModel.fromJson(Map<String, dynamic> json){
    return SettingsModel(
      isMul: json["isMul"] ?? true,
      resRange: RangeValues(
        json["resRangeStart"] ?? 1,
        json["resRangeEnd"] ?? 1000
      ),
      numRange: RangeValues(
        json["numRangeStart"] ?? 1,
        json["numRangeEnd"] ?? 300
      ),
      checkAns: json["checkAns"] ?? false,
      checkNumRange: json["checkNumRange"] ?? false,
      practicePercentage: json["practicePercentage"] ?? 20,
      showBlocks: json["showBlocks"] ?? true,
      answerTime: json["answerTime"] ?? 15,
      processMul: json["processMul"] ?? 0,
      processDiv: json["processDiv"] ?? 0,
      sumCount: json["sumCount"] ?? 0
    );
  }
  SettingsModel copyWith({
    bool? isMul, 
    RangeValues? resRange,
    RangeValues? numRange,
    bool? checkAns,
    bool? checkNumRange,
    double? practicePercentage,
    bool? showBlocks,
    int? answerTime,
    int? processMul,
    int? processDiv,
    int? sumCount
  }) {
    return SettingsModel(
      isMul: isMul ?? this.isMul,
      resRange: resRange ?? this.resRange,
      numRange: numRange ?? this.numRange,
      checkAns: checkAns ?? this.checkAns,
      checkNumRange: checkNumRange ?? this.checkNumRange,
      practicePercentage: practicePercentage ?? this.practicePercentage,
      showBlocks: showBlocks ?? this.showBlocks,
      answerTime: answerTime ?? this.answerTime,
      processMul: processMul ?? this.processMul,
      processDiv: processDiv ?? this.processDiv,
      sumCount: sumCount ?? this.sumCount
    );
  }
}