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

  void init() async {
    await fetchCartItems();

    setBusy(true);
    await _getProducts();
    setBusy(false);
  }

  double get subtotal {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  Future<void> _getProducts() async {
    products = await apiService.getProducts();
  }

  Future<void> fetchCartItems() async {
    setBusy(true);
    try {
      final List<Cart> response = await _apiService.getAllCartItems();
      cartItems = List<Cart>.from(response);
      totalItems = cartItems.length;
    } catch (e) {
      print('Error fetching cart items: $e');
      cartItems.clear();
      totalItems = 0;
    } finally {
      setBusy(false);
    }
  }
}
