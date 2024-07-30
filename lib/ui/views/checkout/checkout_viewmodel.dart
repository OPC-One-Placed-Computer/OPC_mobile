import 'dart:typed_data';

import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';

import 'package:opc_mobile_development/ui/views/order_placed/order_placed_viewmodel.dart';

class CheckoutViewModel extends AppBaseViewModel {
  List<Cart> selectedCartItems = [];
  Map<String, Future<Uint8List>> _imageFutures = {};
  bool _loading = true;
  bool get loading => _loading;

  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? selectedPaymentMethod = 'cod';

  String? get fullName => '${firstName ?? ''} ${lastName ?? ''}';

  bool isEditingAddress = false;
  String? tempAddress;

  CheckoutViewModel(this.selectedCartItems);

  Future<void> fetchUserData() async {
    try {
      setBusy(true);
      final authData = await apiService.getCurrentAuthentication();
      firstName = authData.firstName;
      lastName = authData.lastName;
      address = authData.address;
      tempAddress = authData.address;
      print('Address fetched: $address');
      notifyListeners();
    } catch (e) {
      print('Error fetching user data: $e');
      setError('Error fetching user data: $e');
    } finally {
      setBusy(false);
    }
  }

  void init() async {
    await fetchUserData();
    _loading = true;
    notifyListeners();
    await Future.wait(selectedCartItems
        .map((item) => fetchImageData(item.product.imageName)));

    _loading = false;
    notifyListeners();
  }

  int get totalItems {
    return selectedCartItems.length;
  }

  double get totalAmount {
    double total = 0;
    for (var cart in selectedCartItems) {
      total += cart.product.price * cart.quantity;
    }
    return total;
  }

  double getSubtotal(Cart item) {
    return item.product.price * item.quantity;
  }

  void toggleEditMode() {
    isEditingAddress = !isEditingAddress;
    if (!isEditingAddress) {
      tempAddress = address;
    }
    notifyListeners();
  }

  void updatePaymentMethod(String? paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  Future<void> placeOrder() async {
    try {
      setBusy(true);

      final cartItems =
          selectedCartItems.map((cart) => cart.id.toString()).toList();

      if (cartItems.isEmpty) {
        throw Exception('No cart items selected.');
      }

      if (tempAddress == null || tempAddress!.isEmpty) {
        setError('Address is required');
        return;
      }

      if (selectedPaymentMethod == 'cod') {
        final checkout = await apiService.checkOut(
          fullName ?? '',
          tempAddress!,
          selectedPaymentMethod ?? 'cod',
          totalAmount.toInt(),
          cartItems.cast<String>(),
        );
        print('Order placed successfully: $checkout');

        navigationService.navigateTo(Routes.success_message);
      }
      if (selectedPaymentMethod == 'stripe') {
        final link = await apiService.getPaymentLink(
          fullName ?? '',
          tempAddress!,
          selectedPaymentMethod ?? 'cod',
          totalAmount.toInt(),
          cartItems.cast<String>(),
        );
        navigationService.navigateTo(Routes.payment,
            arguments: WebviewScreenViewArguments(url: link));
      }

      setBusy(false);
    } catch (e) {
      print('Error placing order: $e');
      setError('Error placing order: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  Future<Uint8List> fetchImageData(String imageName) {
    if (_imageFutures.containsKey(imageName)) {
      return _imageFutures[imageName]!;
    }

    final imageFuture =
        ApiServiceImpl().retrieveProductImage(imageName).then((imageData) {
      imageCacheService.setImage(imageName, imageData);
      return imageData;
    });

    _imageFutures[imageName] = imageFuture;
    return imageFuture;
  }
}
