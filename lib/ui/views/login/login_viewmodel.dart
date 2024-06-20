import 'package:opc_mobile_development/app/app_base_view_model.dart';

class LoginViewModel extends AppBaseViewModel {
  String _email = '';
  String _password = '';
  bool _obscureText = true; // Added for password visibility toggle

  String get email => _email;
  String get password => _password;
  bool get obscureText => _obscureText; // Getter for password visibility

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscureText = !_obscureText; // Toggle password visibility
    notifyListeners();
  }

  Future<bool> login() async {
    setBusy(true);
    // Hard-coded credentials
    const String correctEmail = 'user@gmail.com';
    const String correctPassword = 'password123';

    // Simulate a network call with a delay
    await Future.delayed(Duration(seconds: 2));
    setBusy(false);

    // Check if the provided credentials match the hard-coded credentials
    return _email == correctEmail && _password == correctPassword;
  }
}
