import 'dart:typed_data';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';

class ViewOrderPlacedViewModel extends AppBaseViewModel {
  final ApiServiceService _orderService = ApiServiceImpl();
  final ImageCacheService imageCacheService = ImageCacheService();

  bool _isProductsVisible = false;

  bool get isProductsVisible => _isProductsVisible;

  List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems => _orderItems;

  Future<void> setOrderItems(List<OrderItem> items) async {
    _orderItems = items;
    notifyListeners();
  }

  void toggleVisibility() {
    _isProductsVisible = !_isProductsVisible;
    notifyListeners();
  }

  Future<Uint8List> fetchImageData(String imagePath) async {
    final cachedImage = imageCacheService.getImage(imagePath);
    if (cachedImage != null) {
      return cachedImage;
    }

    final imageData = await _orderService.retrieveProductImage(imagePath);
    imageCacheService.setImage(imagePath, imageData);

    return imageData;
  }

  Future<void> cancelOrder(int orderId) async {
    setBusy(true);
    try {
      await _orderService.canceledOrder(orderId);
      _orderItems =
          _orderItems.where((item) => item.orderId != orderId).toList();
      notifyListeners();
    } catch (e) {
      print('Error canceling order: $e');
    } finally {
      setBusy(false);
    }
  }
}

class ImageCacheService {
  final Map<String, Uint8List> _cache = {};

  Uint8List? getImage(String path) => _cache[path];

  void setImage(String path, Uint8List imageData) {
    _cache[path] = imageData;
  }
}
