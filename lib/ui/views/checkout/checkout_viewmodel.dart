import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
  
class CheckoutViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = ApiServiceImpl();
  List<Cart> selectedCartItems = [];

  String? firstName;
  String? lastName;
  String? email;
  String? address;

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  bool isEditingAddress = false;
  String? tempAddress;

  CheckoutViewModel(this.selectedCartItems);

  Future<void> fetchUserData() async {
    try {
      setBusy(true);
      final authData = await _apiService.getCurrentAuthentication();
      firstName = authData.firstName;
      lastName = authData.lastName;
      address = authData.address;
      tempAddress = authData.address;
      print('Address fetched: $address');
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

  double getSubtotal(Cart item) {
    return item.product.price * item.quantity;
  }

  void toggleEditMode() {
    isEditingAddress = !isEditingAddress;
    if (!isEditingAddress) {
      tempAddress = address;
    }
    notifyListeners();
  }

  Future<void> placeOrder() async {
    try {
      setBusy(true);

      final cartIds = selectedCartItems.map((cart) => cart.id).toList();
      if (cartIds.isEmpty) {
        throw Exception('No cart items selected.');
      }

      if (tempAddress == null || tempAddress!.isEmpty) {
        setError('Address is required');
        return;
      }

      final checkout = await _apiService.checkOut(
        fullName ?? '',
        tempAddress!,
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
