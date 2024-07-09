import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/models/checkout.dart';

class CheckoutViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = ApiServiceImpl();
  List<Cart> selectedCartItems = [];

  String? firstName;
  String? lastName;
  String? email;
  String address = 'Guadalupe, Carmen, Bohol';

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  CheckoutViewModel(this.selectedCartItems);

  Future<void> fetchUserData() async {
    try {
      setBusy(true);
      final authData = await _apiService.getCurrentAuthentication();
      firstName = authData.firstName;
      lastName = authData.lastName;
      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      setError('Error fetching user data: $e');
    } finally {
      setBusy(false);
    }
  }

  void init() async {
    await fetchUserData();
  }

  double get totalAmount {
    double total = 0;
    for (var cart in selectedCartItems) {
      total += cart.product.price * cart.quantity;
    }
    return total;
  }

  Future<void> placeOrder() async {
    try {
      setBusy(true);

      final cartIds = selectedCartItems.map((cart) => cart.id).toList();
      if (cartIds.isEmpty) {
        throw Exception('No cart items selected.');
      }

      final checkout = await _apiService.checkOut(
        fullName ?? '',
        address,
        totalAmount.toInt(),
        cartIds.map((id) => {'id': id}).toList(),
      );
      print('Order placed successfully: $checkout');
    } catch (e) {
      print('Error placing order: $e');
      setError('Error placing order: $e');
    } finally {
      setBusy(false);
    }
  }
}
