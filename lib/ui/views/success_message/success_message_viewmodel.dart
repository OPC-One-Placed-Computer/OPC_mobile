import 'dart:async';
import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SuccessMessageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void handleNavigation() {
    Timer(const Duration(seconds: 5), () {
      _navigationService.navigateTo(Routes.homeView);
    });
  }
}
