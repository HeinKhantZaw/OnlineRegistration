import 'package:shared_preferences/shared_preferences.dart';

class pref
{
  final String _kThemePrefs = "allowNotifications";
  Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kThemePrefs) ?? false;
  }

  Future<bool> setTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kThemePrefs, value);
  }
}