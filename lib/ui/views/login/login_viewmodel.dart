import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class LoginViewModel extends AppBaseViewModel {
  String _email = '';
  String _password = '';
  bool _obscureText = true;

  String get email => _email;
  String get password => _password;
  bool get obscureText => _obscureText;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  Future<bool> login() async {
    setBusy(true);
    try {
      final user = await authService.loginUser(email, _password);
      snackbarService.showSnackbar(message: user.token ?? 'null');
      setBusy(false);
      return true;
    } catch (_) {
      snackbarService.showSnackbar(message: Constants.errorMessage);
    }
    setBusy(false);
    return false;
  }
}
