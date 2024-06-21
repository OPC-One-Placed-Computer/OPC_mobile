import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/utils/constants.dart';

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

  Future<void> login() async {
    setBusy(true);
    try {
      final user = await authService.loginUser(email, _password);
      snackbarService.showSnackbar(message: user.token ?? 'null');
    } catch (_) {
      snackbarService.showSnackbar(message: Constants.errorMessage);
    }
    setBusy(false);
  }
}
