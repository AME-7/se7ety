import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  static late SharedPreferences pref;

  static const String onboarding = 'onboarding';
  static const String user = 'user';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<bool> setOnboardingShown() {
    return pref.setBool(onboarding, true);
  }

  static bool isOnboardingShown() {
    return pref.getBool(onboarding) ?? false;
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static Object getData(String key) {
    return pref.get(key) ?? '';
  }

  static Future<void> removeData(String key) async {
    await pref.remove(key);
  }

  static Future<void> clear() async {
    await pref.clear();
  }
}

// Memory Management

// token , value
// user , value
