import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';

class AddToCartViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = ApiServiceImpl();
  Set<int> selectedIndices = {}; // Store the indices of checked checkboxes
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

  // Method to calculate total
  double get total {
    const double shippingCost = 10.0;
    return subtotal + shippingCost;
  }

  Future<void> _getProducts() async {
    products = await apiService.getProducts();
  }

  void toggleCheckbox(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
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

  Future<void> deleteSelectedItems() async {
    setBusy(true);
    List<int> indices = selectedIndices.toList();

    for (int i = 0; i < indices.length; i++) {
      int index = indices[i];
      if (index >= 0 && index < cartItems.length) {
        int cartId = cartItems[index].id ?? 0;
        await _apiService.deleteFromCart(cartId);
      }
    }

    await fetchCartItems();
    selectedIndices.clear();
    setBusy(false);
    notifyListeners();
  }
}
