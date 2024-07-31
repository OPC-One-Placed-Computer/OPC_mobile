import 'dart:developer';

import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/user.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/api/auth/auth_api_service.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBaseViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiServiceService>();
  final authService = locator<AuthApiService>();
  final snackbarService = locator<SnackbarService>();
  final sharedPrefService = locator<SharedPreferenceService>();

  Future<User?> checkAuthentication() async {
    try {
      final cachedUser = await sharedPrefService.getUser();
      if (cachedUser != null) {
        return cachedUser;
      } else {
        navigationService.navigateTo(Routes.login);
        return null;
      }
    } catch (e) {
      log(e.toString());
      navigationService.navigateTo(Routes.login);
    }
    return null;
  }
}
