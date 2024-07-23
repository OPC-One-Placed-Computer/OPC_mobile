import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';

class PlaceOrderViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = ApiServiceImpl();

  Set<int> selectedIndices = {};
  int quantity = 1;
  int totalItems = 0;
  List<Cart> cartItems = [];
  List<Product> products = [];

  String? firstName;
  String? lastName;
  String? email;
  String address = 'Guadalupe, Carmen, Bohol';

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

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
    await fetchCartItems();
  }

  double get subtotal {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  Future<void> fetchCartItems() async {
    setBusy(true);
    try {
      final List<Cart> response = await _apiService.getAllCartItems();
      cartItems = List<Cart>.from(response);
      totalItems = cartItems.length;
      notifyListeners();
    } catch (e) {
      print('Error fetching cart items: $e');
      cartItems.clear();
      totalItems = 0;
    } finally {
      setBusy(false);
    }
  }
}
