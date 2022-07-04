
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpstickermaker/values/strings/strings.dart';

class StorageManager {
  static Future<SharedPreferences>? get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefs;

  static Future<SharedPreferences?> initPrefs() async {
    _prefs = await _instance;
    return _prefs;
  }

  static String? getImage() {
    return _prefs?.getString("savedImage");
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }
  static Future<bool> setStringList(String key, List<String> value) async {
    var prefs = await _instance;
    return prefs?.setStringList(key, value) ?? Future.value(false);
  }
  static Future<List<String>?> getStringList() async {
    return  _prefs?.getStringList(Strings.imageKey);
  }

  static void clearAll() {
    _prefs?.clear();
  }

  static void deleteImage() {
    _prefs?.remove("imgPath");
  }
}
