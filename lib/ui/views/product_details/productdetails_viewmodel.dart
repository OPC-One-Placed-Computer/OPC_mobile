import 'dart:typed_data';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_view.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_viewmodel.dart';

class ProductdetailsViewModel extends AppBaseViewModel {
  @override
  final ApiServiceImpl apiService = ApiServiceImpl();
  late Product product;

  int quantity = 1;
  Uint8List? imageData;

  ProductdetailsViewModel(this.product);

  void init() async {
    setBusy(true);
    await _getProduct();
    await fetchImageData();
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
    } catch (e) {
      print('Error fetching product: $e');
    }
  }

  Future<void> fetchImageData() async {
    try {
      final cachedImage = imageCacheService.getImage(product.imagePath);
      if (cachedImage != null) {
        imageData = cachedImage;
      } else {
        final data = await apiService.retrieveProductImage(product.imagePath);
        imageCacheService.setImage(product.imagePath, data);
        imageData = data;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  Future<void> addToCart() async {
    try {
      await apiService.addToCart(product.id!, quantity);
      print('Product added to cart successfully');
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
}
