import 'package:opc_mobile_development/models/user.dart';

abstract interface class SharedPreferenceService {
  Future<void> setUser(User user);
  Future<User?> getUser();
  Future<void> removeUser();
}
