import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductdetailsViewModel extends AppBaseViewModel {
  ProductdetailsViewModel(this.product);

  Product product;

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
}
