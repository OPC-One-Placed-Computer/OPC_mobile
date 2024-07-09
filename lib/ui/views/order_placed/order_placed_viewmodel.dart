import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';

class OrderPlacedViewModel extends AppBaseViewModel {
  final ApiServiceService _orderService = ApiServiceImpl();

  List<Checkout> _orders = [];
  List<Checkout> get orders => _orders;

  final Map<int, bool> _expandedOrders = {};
  Map<int, bool> get expandedOrders => _expandedOrders;

  Future<void> fetchOrders() async {
    setBusy(true);
    try {
      _orders = await _orderService.getOrdersDetails();
      print('Fetched Orders: $_orders'); 

      for (var order in _orders) {
        _expandedOrders[order.orderId] = false;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      setBusy(false);
    }
  }

  void toggleOrderExpansion(int orderId) {
    _expandedOrders[orderId] = !(_expandedOrders[orderId] ?? false);
    notifyListeners();
  }
}
