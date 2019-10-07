import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  Future<bool> setDarkTheme(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setBool('isDark', value);
  }

  Future<dynamic> getDarkTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isDark');
  }

}