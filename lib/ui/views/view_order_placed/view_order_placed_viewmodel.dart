import 'dart:typed_data';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/Order.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_viewmodel.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/utils/constants.dart';

class ViewOrderPlacedViewModel extends AppBaseViewModel {
  ViewOrderPlacedViewModel(this._orderItems);
  final ApiServiceService _orderService = ApiServiceImpl();
  final ImageCacheService imageCacheService = ImageCacheService();

  bool _isProductsVisible = true;

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

  Future<Uint8List> fetchImageData(String imageName) async {
    final cachedImage = imageCacheService.getImage(imageName);
    if (cachedImage != null) {
      return cachedImage;
    }

    final imageData = await _orderService.retrieveProductImage(imageName);
    imageCacheService.setImage(imageName, imageData);

    return imageData;
  }

  Future<void> cancelOrder(int orderId) async {
    setBusy(true);
    try {
      await _orderService.canceledOrder(orderId);
      _orderItems =
          _orderItems.where((item) => item.orderId != orderId).toList();
      notifyListeners();
      snackbarService.showSnackbar(message: Constants.cancelOrderSuccess);
    } catch (e) {
      snackbarService.showSnackbar(message: Constants.cancelOrderFailed);
    } finally {
      setBusy(false);
    }
  }

  Future<void> openStripeForm(Order order) async {
    setBusy(true);
    try {
      final link = await _orderService.getSessionStripe(order.stripeSessionId!);
      navigationService.navigateTo(Routes.payment,
          arguments: WebviewScreenViewArguments(url: link));
    } catch (e) {
      print('Error opening Stripe form: $e');
    } finally {
      setBusy(false);
    }
  }
}
