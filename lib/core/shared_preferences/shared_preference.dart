import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreference? _instance;
  static SharedPreferences? _sharedPreferences;
  SharedPreference._();
  static SharedPreference get instance {
    _instance ??= SharedPreference._();
    return _instance!;
  }
  static Future<void> init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<bool> saveData<T>(String key, T value) async{
    if(_sharedPreferences == null) return false;
    switch(T){
      case String:
        return await _sharedPreferences!.setString(key, value as String);
      case int:
        return await _sharedPreferences!.setInt(key, value as int);
      case double:
        return await _sharedPreferences!.setDouble(key, value as double);
      case bool:
        return await _sharedPreferences!.setBool(key, value as bool);
      case const (List<String>):
        return await _sharedPreferences!.setStringList(key, value as List<String>);
      default:
        if (value != null) {
          return await _sharedPreferences!.setString(key, json.encode(value));
        }
        return false;
    }
  }
  T? getData<T>(String key){
    if(_sharedPreferences == null) return null;
    switch(T){
      case String:
        return _sharedPreferences!.getString(key) as T;
      case int:
        return _sharedPreferences!.getInt(key) as T;
      case double:
        return _sharedPreferences!.getDouble(key) as T;
      case bool:
        return _sharedPreferences!.getBool(key) as T;
      case const (List<String>):
        return _sharedPreferences!.getStringList(key) as T;
      default:
        if (_sharedPreferences!.getString(key) != null) {
          return json.decode(_sharedPreferences!.getString(key) as String) as T;
        }
        return null;
    }
  }
  Future<bool> saveObject<T>(String key, T value, T Function(Map<String, dynamic>) fromJson) async{
    if (_sharedPreferences == null) return false;
    try{
      return await _sharedPreferences!.setString(key, json.encode(value));
    }catch(e){
      return false;
    }
  }
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (_sharedPreferences == null) return null;
    try{
      if (_sharedPreferences!.getString(key) != null) {
        final Map<String, dynamic> jsonMap = json.decode(_sharedPreferences!.getString(key) as String);
        return fromJson(jsonMap); 
      }
    }catch(e){
      return null;
    }
    return null;
  }
  Future<bool> removeData(String key) async{
    if(_sharedPreferences == null) return false;
    return await _sharedPreferences!.remove(key);
  }
  Future<bool> clearAll() async{
    if(_sharedPreferences == null) return false;
    return await _sharedPreferences!.clear();
  }
  bool hasKey(String key){
    if(_sharedPreferences == null) return false;
    return _sharedPreferences!.containsKey(key);
  }
}