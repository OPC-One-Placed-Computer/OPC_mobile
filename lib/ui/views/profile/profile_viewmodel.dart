import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final ApiServiceService _apiService;

  ProfileViewModel({required ApiServiceService apiService})
      : _apiService = apiService;

  String? firstName;
  String? lastName;
  String? email;
  String address = '123 Placeholder St, Placeholder City, PL 12345';

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    try {
      setBusy(true);
      final authData = await _apiService.getCurrentAuthentication();
      firstName = authData.firstName;
      lastName = authData.lastName;
      email = authData.email;
      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      setError('Error fetching user data: $e');
    } finally {
      setBusy(false);
    }
  }

  void saveUserData(String newFirstName, String newLastName, String newEmail,
      String newAddress) {
    firstName = newFirstName;
    lastName = newLastName;
    email = newEmail;
    address = newAddress;
    toggleEditing();
    notifyListeners();
  }
}
