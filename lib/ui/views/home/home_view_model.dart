import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/ui/views/add_to_cart/add_to_cart_view.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_view.dart';
import 'package:opc_mobile_development/ui/views/products/products_view.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class HomeViewModel extends AppBaseViewModel {
  @override
  final ApiServiceService apiService;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late String firstName;
  late String lastName;
  late String email;
  String? address;
  int? userId;
  String? imageName;
  String? imagePath;

  Uint8List? _profileImage;
  Uint8List? get profileImage => _profileImage;

  User? user;

  HomeViewModel({required this.apiService}) {
    _checkAuthentication();
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> _checkAuthentication() async {
    try {
      final cachedUser = await sharedPrefService.getUser();
      if (cachedUser != null) {
        user = cachedUser;
      } else {
        navigationService.navigateTo(Routes.login);
      }
    } catch (e) {
      log(e.toString());
      navigationService.navigateTo(Routes.login);
    }
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return ProductsView();
      case 1:
        return const AddToCartView();
      case 2:
        return const OrderPlacedView();
      default:
        return ProductsView();
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

  Future<void> displayProfileImage(String path) async {
    try {
      setBusy(true);
      final downloadedImage = await apiService.retrieveProfileImage(path);
      _profileImage = downloadedImage;
      notifyListeners();
    } catch (e) {
      print('Error downloading profile image: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      setBusy(true);

      final authData = await apiService.getCurrentAuthentication();
      userId = authData.id;
      firstName = authData.firstName!;
      lastName = authData.lastName!;
      email = authData.email!;
      address = authData.address;
      imageName = authData.imageName;
      imageName = authData.imageName;

      if (imageName != null && imageName!.isNotEmpty) {
        await displayProfileImage(imageName!);
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      setError('Error fetching user data: $e');
    } finally {
      setBusy(false);
    }
  }
}
