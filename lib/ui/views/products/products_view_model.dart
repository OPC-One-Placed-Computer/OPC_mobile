import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductsViewModel extends AppBaseViewModel {
  List<Product> products = [];

  void init() async {
    setBusy(true);
    await _getProducts();
    setBusy(false);
  }

  Future<void> _getProducts() async {
    products = await apiService.getProducts();
  }
}
