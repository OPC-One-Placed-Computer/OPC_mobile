import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBaseViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiServiceService>();
}
