// lib/data/services/preference_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  late final SharedPreferences _prefs;

  PreferenceService._internal();

  static Future<PreferenceService> initAndCreate() async {
    final service = PreferenceService._internal();
    service._prefs = await SharedPreferences.getInstance();

    return service;
  }

  // Set String
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  // Get String
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Set Bool
  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  // Get String
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Set String
  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  // Keys
  static const String keyDistance = 'distance';
  static const String keyVibrationDuration = 'vibration_duration';
  static const String keyVibrationPattern = 'vibration_pattern';
  static const String keyServiceActive = 'service_active';

  // Specific Getters
  int getDistance() => _prefs.getInt(keyDistance) ?? 3;
  int getVibrationDuration() => _prefs.getInt(keyVibrationDuration) ?? 3;
  bool getVibrationPattern() =>
      _prefs.getBool(keyVibrationPattern) ?? true; // Default Continuous
  bool getServiceActive() => _prefs.getBool(keyServiceActive) ?? false;

  // Specific Setters
  Future<bool> setDistance(int value) => _prefs.setInt(keyDistance, value);
  Future<bool> setVibrationDuration(int value) =>
      _prefs.setInt(keyVibrationDuration, value);
  Future<bool> setVibrationPattern(bool value) =>
      _prefs.setBool(keyVibrationPattern, value);
  Future<bool> setServiceActive(bool value) =>
      _prefs.setBool(keyServiceActive, value);

  // Get String
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  //Delete Value
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }
}
