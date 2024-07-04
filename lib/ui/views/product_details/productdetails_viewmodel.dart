import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';

class ProductdetailsViewModel extends AppBaseViewModel {
  ProductdetailsViewModel(this.product);

  final ApiServiceImpl apiService = ApiServiceImpl();
  int quantity = 1;
  Product product;

  void init() async {
    setBusy(true);
    await _getProduct();
    print(product);
    setBusy(false);
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

  Future<void> _getProduct() async {
    try {
      product = await apiService.getProduct(product.id!.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addToCart() async {
    try {
      await apiService.addToCart(product.id!, quantity);
      print('Product added to cart successfully');
    } catch (e) {
      print('Error: $e');
    }
  }
}
