import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class LoginViewModel extends AppBaseViewModel {
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  bool _submitted = false;
  String? _emailError;
  String? _passwordError;

  String get email => _email;
  String get password => _password;
  bool get obscureText => _obscureText;
  bool get submitted => _submitted;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  set emailError(String? value) {
    _emailError = value;
    notifyListeners();
  }

  set passwordError(String? value) {
    _passwordError = value;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    if (email.isNotEmpty) {
      emailError = null;
      if (!_isValidEmail(email)) {
        emailError = 'Please enter a valid email';
      }
    }
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    if (password.isNotEmpty) {
      passwordError = null;
      if (password.length < 8) {
        passwordError = 'Password must be at least 8 characters';
      }
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  Future<bool> login() async {
    setBusy(true);
    _submitted = true;
    try {
      if (_email.isEmpty) {
        emailError = 'Email is required';
      } else if (!_isValidEmail(_email)) {
        emailError = 'Please enter a valid email';
      }

      if (_password.isEmpty) {
        passwordError = 'Password is required';
      } else if (_password.length < 8) {
        passwordError = 'Password must be at least 8 characters';
      }

      if (emailError != null || passwordError != null) {
        setBusy(false);
        return false;
      }

      final user = await authService.loginUser(email, _password);
      if (user.token != null) {
        snackbarService.showSnackbar(message: Constants.loginSuccesful);
      } else {
        snackbarService.showSnackbar(message: Constants.errorLogin);
      }

      setBusy(false);
      return true;
    } catch (_) {
      snackbarService.showSnackbar(message: Constants.errorLogin);
    }
    setBusy(false);
    return false;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
