import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/Order.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart';

class OrderPlacedViewModel extends AppBaseViewModel {
  final ApiServiceService _orderService = ApiServiceImpl();

  List<Order> _orders = [];
  List<Order> get orders => _orders;

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
      _hasMoreOrders = true;
    }

    setBusy(true);
    try {
      const pageSize = 25;
      final newOrders = await _orderService.getOrdersDetails(
        page: _currentPage,
        pageSize: pageSize,
      );
      print('Fetched Orders: $newOrders');

      if (newOrders.isNotEmpty) {
        _orders.addAll(newOrders);
        _currentPage++;

        for (var order in newOrders) {
          _expandedOrders[order.id!] = false;
        }

        if (newOrders.length < pageSize) {
          _hasMoreOrders = false;
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

  Future<void> refreshOrders() async {
    await fetchOrders(loadMore: false);
  }

  void toggleOrderExpansion(int orderId) {
    _expandedOrders[orderId] = !(_expandedOrders[orderId] ?? false);
    notifyListeners();
  }

  void navigateToOrderDetails(
      BuildContext context, List<OrderItem> orderItems, Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewOrderPlacedView(
          orderItems: orderItems,
          order: order,
          onProductTapped: (Product value) {},
        ),
      ),
    );
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
}

class ImageCacheService {
  final Map<String, Uint8List> _cache = {};

  Uint8List? getImage(String path) => _cache[path];

  void setImage(String path, Uint8List imageData) {
    _cache[path] = imageData;
  }
}

final imageCacheService = ImageCacheService();
