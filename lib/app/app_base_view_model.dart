import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBaseViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
}
