import 'package:stacked/stacked.dart';
import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to LoginView after the delay
    _navigationService.replaceWith(Routes.productsView);
  }
}
