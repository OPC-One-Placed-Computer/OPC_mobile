import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductdetailsViewModel extends AppBaseViewModel {
  ProductdetailsViewModel(this.product);

  Product product;
  int _quantity = 1;

  void init() async {
    setBusy(true);
    await _getProduct();
    print(product);
    setBusy(false);
  }

  Future<void> _getProduct() async {
    try {
      product = await apiService.getProduct(product.id!.toString());
    } catch (_) {
      rethrow;
    }
  }

  int get quantity => _quantity;

  void incrementQuantity() {
    _quantity++;
    notifyListeners(); // Notify listeners to update UI
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners(); // Notify listeners to update UI
    }
  }
}
