import 'dart:convert';

import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServiceImpl implements SharedPreferenceService {
  @override
  Future<User?> getUser() async {
    try {
      final shared = await SharedPreferences.getInstance();
      final user = shared.getString(Constants.userKey);
      return user != null ? User.fromJson(jsonDecode(user)) : null;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> setUser(User user) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(Constants.userKey, jsonEncode(user.toJson()));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeUser() async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(Constants.userKey);
    } catch (_) {
      rethrow;
    }
  }
}
