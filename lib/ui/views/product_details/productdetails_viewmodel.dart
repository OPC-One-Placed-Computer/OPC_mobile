import 'package:stacked/stacked.dart';

class ProductdetailsViewModel extends BaseViewModel {
  int _quantity = 1;

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
