import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class SignupViewModel extends AppBaseViewModel {
  String _email = '';
  String _password = '';
  bool _obscureText = true; // Added for password visibility toggle
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

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

  Future<void> register() async {
    setBusy(true);
    try {
      await authService
          .registerUser(
              User(
                  email: email,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text),
              _password)
          .then((value) {
        if (value) {
          snackbarService.showSnackbar(message: 'Register Successful');
          navigationService.navigateTo(Routes.login);
        } else {
          snackbarService.showSnackbar(message: 'Failed to register');
        }
      });
    } catch (_) {
      snackbarService.showSnackbar(message: Constants.errorMessage);
    }
    setBusy(false);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
