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
    return prefs.getBool('privacy_policy_acceptance') ?? false;
  }
}