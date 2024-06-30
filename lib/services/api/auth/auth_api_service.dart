import 'package:opc_mobile_development/models/user.dart';

abstract interface class AuthApiService {
  Future<bool> registerUser(User user, String password);
  Future<User> loginUser(String email, String password);
  Future<bool> logout(User user);
  
}
