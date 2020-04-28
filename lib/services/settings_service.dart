import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // ------------------------------------------------
  //               Private methods
  // ------------------------------------------------
  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  // ------------------------------------------------
  //               Public methods
  // ------------------------------------------------
  // ------------- Privacy Policy -------------------
  void setPrivacyPolicyAcceptance(bool isAccepted) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setBool('privacy_policy_acceptance', isAccepted);
  }

  Future<bool> get isPrivacyPolicyAccepted async {
    SharedPreferences prefs = await _getInstance();
    return prefs.getBool('privacy_policy_acceptance') ?? true;
  }
  // ------------------------------------------------
  // -----------------App Settings-------------------
  void setUnit(bool _isMetric) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setBool('isMetric', _isMetric);
  }

  Future<bool> get isMetric async {
    SharedPreferences prefs = await _getInstance();
    return prefs.getBool('isMetric') ?? false;
  }

  void setLang(String _lang) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setString('language', _lang);
  }

  Future<String> get getLang async {
    SharedPreferences prefs = await _getInstance();
    return prefs.getString('language') ?? 'en';
  }

  void setDevice(String _device) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setString('device', _device);
  }

  Future<String> get getDevice async {
    SharedPreferences prefs = await _getInstance();
    return prefs.getString('device') ?? 'Feetback Mat';
  }

  void setTheme(bool _isLight) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setBool('theme', _isLight);
  }

  Future<bool> get isLightTheme async {
    SharedPreferences prefs = await _getInstance();
    return prefs.getBool('theme') ?? true;
  }

  void setNotifications(List<String> _notificationStrings ) async {
    SharedPreferences prefs = await _getInstance();
    await prefs.setStringList('notifications', _notificationStrings);
  }

  Future<List<String>> get getNotifications async {
    SharedPreferences prefs  = await _getInstance();
    return prefs.getStringList('notifications') ?? ["true"];
  }

  Future<bool> getNot()async{
    SharedPreferences prefs  = await _getInstance();
    List<String> temp = prefs.getStringList("notifications");
    print(temp);
    return (temp[0] == "true" ?? "true");
  }
}
  