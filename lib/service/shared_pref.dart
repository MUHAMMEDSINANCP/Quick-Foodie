import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userAddressKey = "USERADDRESSKEY";
  static String userWalletKey = "USERWALLETKEY";
  static String userProfileKey = "USERPROFILEKEY";

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userEmailKey, getUserEmail);
  }

  Future<bool> saveUserAddress(String getUserAddress) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userAddressKey, getUserAddress);
  }

  Future<bool> saveUserProfile(String getUserProfile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userProfileKey, getUserProfile);
  }

  Future<bool> saveUserWallet(String getUserWallet) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(userWalletKey, getUserWallet);
  }

  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmailKey);
  }

  Future<String?> getUserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userAddressKey);
  }

  Future<String?> getUserWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userWalletKey);
  }

  Future<String?> getUserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userProfileKey);
  }

  // Method to clear the stored profile picture
  Future<void> clearUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userProfileKey);
  }
}
