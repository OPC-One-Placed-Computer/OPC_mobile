import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class SignupViewModel extends AppBaseViewModel {
  String _email = '';
  String _password = '';
  bool _obscureText = true;
  bool _submitted = false;
  String? _emailError;
  String? _passwordError;
  bool _firstNameError = false;
  bool _lastNameError = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String get email => _email;
  String get password => _password;
  bool get obscureText => _obscureText;
  bool get submitted => _submitted;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get firstNameError => _firstNameError;
  bool get lastNameError => _lastNameError;

  set emailError(String? value) {
    _emailError = value;
    notifyListeners();
  }

  set passwordError(String? value) {
    _passwordError = value;
    notifyListeners();
  }

  set firstNameError(bool value) {
    _firstNameError = value;
    notifyListeners();
  }

  set lastNameError(bool value) {
    _lastNameError = value;
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

  void setFirstName(String firstName) {
    firstNameController.text = firstName;
    if (firstName.isNotEmpty) {
      firstNameError = false;
    }
    notifyListeners();
  }

  void setLastName(String lastName) {
    lastNameController.text = lastName;
    if (lastName.isNotEmpty) {
      lastNameError = false;
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  Future<void> register() async {
    setBusy(true);
    _submitted = true;
    try {
      if (firstNameController.text.isEmpty) {
        firstNameError = true;
      }
      if (lastNameController.text.isEmpty) {
        lastNameError = true;
      }
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

      if (firstNameError || lastNameError || emailError != null || passwordError != null) {
        setBusy(false);
        return;
      }

      final success = await authService.registerUser(
        User(
          email: email,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
        ),
        _password,
      );

      if (success) {
        snackbarService.showSnackbar(message: 'Register Successful');
        navigationService.navigateTo(Routes.login);
      } else {
        snackbarService.showSnackbar(message: 'Failed to register');
      }
    } catch (_) {
      snackbarService.showSnackbar(message: Constants.errorMessage);
    }
    setBusy(false);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
