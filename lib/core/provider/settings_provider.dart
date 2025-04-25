import 'package:flutter/material.dart';
import 'package:math_app/core/shared_preferences/shared_preference.dart';
import 'package:math_app/model/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  static const String settingKey = "math_app_settings";
  late SettingsModel _settings;
  SettingsModel get settings => _settings;
  Future<void> init() async {
    loadData();
  }
  void loadData(){
    final settingsData = SharedPreference.instance.getObject<SettingsModel>(
      settingKey,
      (json) => SettingsModel.fromJson(json)
    );
    _settings = settingsData ?? SettingsModel();
    notifyListeners();
  }
  void notifyAllChanged() => notifyListeners();
  Future<void> _setupSettings() async{
    await SharedPreference.instance.saveObject<SettingsModel>(
      settingKey,
      _settings,
      SettingsModel.fromJson
    );
    notifyListeners();
  }
  void updateMode(bool isMul) {
    _settings = _settings.copyWith(isMul: isMul);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateProcess(bool isMul, int process){
    if(isMul){
      _settings = _settings.copyWith(processMul: process);
    }else{
      _settings = _settings.copyWith(processDiv: process);
    }
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateResultRange(RangeValues range) {
    _settings = _settings.copyWith(resRange: range);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateNumberRange(RangeValues range) {
    _settings = _settings.copyWith(numRange: range);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateCheckNumRange(bool checkNumRange){
    _settings = _settings.copyWith(checkNumRange: checkNumRange);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateCheck(bool checkAns) {
    _settings = _settings.copyWith(checkAns: checkAns);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updatePracticePercentage(double practicePercentage) {
    _settings = _settings.copyWith(practicePercentage: practicePercentage);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateBlocks(bool showBlocks) {
    _settings = _settings.copyWith(showBlocks: showBlocks);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  void updateAnswerTime(int times) {
    _settings = _settings.copyWith(answerTime: times);
    _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
  Future<void> reset() async {
    _settings = SettingsModel();
    await _setupSettings();
    notifyListeners();
    notifyAllChanged();
  }
}