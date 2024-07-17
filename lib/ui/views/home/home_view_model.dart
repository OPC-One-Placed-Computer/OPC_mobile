  import 'dart:developer';

  import 'package:flutter/material.dart';
  import 'package:opc_mobile_development/app/app.router.dart';
  import 'package:opc_mobile_development/app/app_base_view_model.dart';
  import 'package:opc_mobile_development/models/user.dart';
  import 'package:opc_mobile_development/ui/views/add_to_cart/add_to_cart_view.dart';
  import 'package:opc_mobile_development/ui/views/products/products_view.dart';
  import 'package:opc_mobile_development/ui/views/profile/profile_view.dart';
  import 'package:opc_mobile_development/utils/constants.dart';

class HomeViewModel extends AppBaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  User? user;

  void init() async {
    await _getCachedUser();
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> _getCachedUser() async {
    try {
      final user = await sharedPrefService.getUser();
      print('user $user');
      this.user = user;
    } catch (_) {}
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const ProductsView();
      case 1:
        return const AddToCartView();
      case 2:
        return const ProfileView();
      default:
        return const ProductsView();
    }
  }

  Future<void> checkAuthenticationAndNavigate(VoidCallback action) async {
    if (user != null) {
      action();
    } else {
      navigationService.navigateTo(Routes.login);
    }
  }

  void logout() async {
    try {
      final loggedOut = await authService.logout(user!);
      if (loggedOut) {
        navigationService.pushNamedAndRemoveUntil(Routes.login);
      }
    } catch (e) {
      log(e.toString());
      snackbarService.showSnackbar(message: Constants.errorMessage);
    }
  }
}

