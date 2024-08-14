import 'package:shared_preferences/shared_preferences.dart';

class AHA {
  static SharedPreferences? sharedPref;

  static init() async {
    sharedPref = await SharedPreferences.getInstance();
    print("getInstancegetInstancegetInstancegetInstancegetInstancegetInstance");
  }

  static Future<bool> SavaData({required String key, required value}) async {
    if (sharedPref == null) {
      await init();
    }
    try {
      if (value is int)
        return await sharedPref!.setInt(key, value);
      else if (value is double)
        return await sharedPref!.setDouble(key, value);
      else if (value is String)
        return await sharedPref!.setString(key, value);
      else {
        print(value);
        return await sharedPref!.setBool(key, value);
      }
    } catch (e) {
      print(e.toString() + "Error");
      return false;
    }
  }

    static Future< dynamic> readData({required String key}) async {
      //
      if (sharedPref == null) await init();

      return await sharedPref!.get(key);
    }

  static Future<bool> clearvalue({required key}) async {
    if (sharedPref == null) await init();

    return sharedPref!.remove(key);
  }
}

/*import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';

class AHA {
  static SharedPreferences? sharedPref;

  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
    print("SharedPreferences instance initialized");
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (sharedPref == null) {
      await init();
    }

    try {
      if (value is int) {
        return await sharedPref!.setInt(key, value);
      } else if (value is double) {
        return await sharedPref!.setDouble(key, value);
      } else if (value is String) {
        return await sharedPref!.setString(key, value);
      } else {
        return await sharedPref!.setBool(key, value);
      }
    } catch (e) {
      print(e.toString() + "Error");
      return false;
    }
  }

  static dynamic readData({required String key}) {
    if (sharedPref == null) {
      return null;
    }

    return sharedPref!.get(key);
  }
}
 */