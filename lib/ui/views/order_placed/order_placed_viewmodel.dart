import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart';

class OrderPlacedViewModel extends AppBaseViewModel {
  final ApiServiceService _orderService = ApiServiceImpl();

  List<Checkout> _orders = [];
  List<Checkout> get orders => _orders;

  final Map<int, bool> _expandedOrders = {};
  Map<int, bool> get expandedOrders => _expandedOrders;

  int _currentPage = 1;
  bool _hasMoreOrders = true;

  Future<void> fetchOrders({bool loadMore = false}) async {
    if (loadMore && !_hasMoreOrders) return;

    if (!loadMore) {
      _currentPage = 1;
      _orders.clear();
      _expandedOrders.clear();
    }

    setBusy(true);
    try {
      final newOrders = await _orderService.getOrdersDetails(
          page: _currentPage, pageSize: 10);
      print('Fetched Orders: $newOrders');

      if (newOrders.isNotEmpty) {
        _orders.addAll(newOrders);
        _currentPage++;

        for (var order in newOrders) {
          _expandedOrders[order.orderId] = false;
        }
      } else {
        _hasMoreOrders = false;
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

  Future<Uint8List> fetchImageData(String imagePath) async {
    final cachedImage = imageCacheService.getImage(imagePath);
    if (cachedImage != null) {
      return cachedImage;
    }

    final imageData = await ApiServiceImpl().retrieveProductImage(imagePath);
    imageCacheService.setImage(imagePath, imageData);

    return imageData;
  }

  void navigateToOrderDetails(
      BuildContext context, List<OrderItem> orderItems, Checkout order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ViewOrderPlacedView(orderItems: orderItems, checkout: order),
      ),
    );
  }
}

class ImageCacheService {
  final Map<String, Uint8List> _cache = {};

  Uint8List? getImage(String path) => _cache[path];

  void setImage(String path, Uint8List imageData) {
    _cache[path] = imageData;
  }
}

final imageCacheService = ImageCacheService();
