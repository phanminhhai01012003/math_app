import 'package:flutter/material.dart';
import 'package:math_app/core/shared_preferences/shared_preference.dart';
import 'package:math_app/model/settings_model.dart';

class SettingsProvider extends ChangeNotifier {
  static const String settingKey = "Cài đặt";
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
  }
  void updateResultRange(RangeValues range) {
    _settings = _settings.copyWith(resRange: range);
    _setupSettings();
    notifyListeners();
  }
  void updateNumberRange(RangeValues range) {
    _settings = _settings.copyWith(numRange: range);
    _setupSettings();
    notifyListeners();
  }
  void updateCheck(bool checkAns) {
    _settings = _settings.copyWith(checkAns: checkAns);
    _setupSettings();
    notifyListeners();
  }
  void updatePracticePercentage(double practicePercentage) {
    _settings = _settings.copyWith(practicePercentage: practicePercentage);
    _setupSettings();
    notifyListeners();
  }
  void updateBlocks(bool showBlocks) {
    _settings = _settings.copyWith(showBlocks: showBlocks);
    _setupSettings();
    notifyListeners();
  }
  void updateAnswerTime(int times) {
    _settings = _settings.copyWith(answerTime: times);
    _setupSettings();
    notifyListeners();
  }
  Future<void> reset() async {
    _settings = SettingsModel();
    await _setupSettings();
    notifyListeners();
  }
}