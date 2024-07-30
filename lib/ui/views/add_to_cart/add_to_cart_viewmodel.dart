import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';

class AddToCartViewModel extends AppBaseViewModel {
  final ApiServiceService _apiService = ApiServiceImpl();
  Set<int> selectedIndices = {};
  List<Cart> cartItems = [];
  List<Product> products = [];
  late Product product;

  int quantity = 1;

  bool get isAllSelected => selectedIndices.length == cartItems.length;

  int get totalItems {
    return cartItems.fold(0, (total, cartItem) => total + cartItem.quantity);
  }

  void init() async {
    await fetchCartItems();
  }

  double get subtotal {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  double get total {
    const double shippingCost = 0;
    return subtotal + shippingCost;
  }

  void toggleCheckbox(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    notifyListeners();
  }

  void incrementQuantity(int index) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      await modifyQuantity(cartItems[index].id!, cartItems[index].quantity);
      await fetchCartItems();
      notifyListeners();
    }
  }

  void decrementQuantity(int index) async {
    if (index >= 0 &&
        index < cartItems.length &&
        cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      await modifyQuantity(cartItems[index].id!, cartItems[index].quantity);
      await fetchCartItems();
      notifyListeners();
    }
  }

  Future<void> fetchCartItems() async {
    setBusy(true);
    try {
      final List<Cart> response = await _apiService.getAllCartItems();
      cartItems = List<Cart>.from(response);
    } catch (e) {
      print('Error fetching cart items: $e');
      cartItems.clear();
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> deleteSelectedItems() async {
    setBusy(true);
    List<int> indices = selectedIndices.toList();

    for (int i = 0; i < indices.length; i++) {
      int index = indices[i];
      if (index >= 0 && index < cartItems.length) {
        int cartId = cartItems[index].id ?? 0;
        try {
          await _apiService.deleteFromCart(cartId);
        } catch (e) {
          print('Error deleting cart item with id $cartId: $e');
        }
      }
    }

    await fetchCartItems();
    selectedIndices.clear();
    setBusy(false);
    notifyListeners();
  }

  void toggleSelectAllItems() {
    if (selectedIndices.length == cartItems.length) {
      selectedIndices.clear();
    } else {
      selectedIndices =
          Set<int>.from(List.generate(cartItems.length, (index) => index));
    }
    notifyListeners();
  }

  List<Cart> getSelectedCartItems() {
    return selectedIndices.map((index) => cartItems[index]).toList();
  }

  void navigateToProductDetails(Product product) {
    navigationService.navigateTo(
      Routes.products_view,
      arguments: ProductdetailsViewArguments(product: product),
    );
  }

  Future<void> modifyQuantity(int cartId, int quantity) async {
    try {
      await _apiService.updateQuantity(cartId, quantity);
      print('Product quantity updated successfully: $quantity');
    } catch (e) {
      print('Error updating product quantity: $e');
    }
  }
}
