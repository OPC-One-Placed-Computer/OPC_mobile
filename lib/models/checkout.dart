import 'package:opc_mobile_development/models/product.dart';

class Checkout {
  Checkout({
    this.id,
    required this.userId,
    required this.orderId,
    required this.orderItems,
    required this.fullName,
    required this.shippingAddress,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  final int? id;
  final int userId;
  final int orderId;
  final List<OrderItem> orderItems;
  final String fullName;
  final String status;
  final String shippingAddress;
  final double total;
  final DateTime createdAt;

  factory Checkout.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['created_at']);

    return Checkout(
      id: json['cart_id'] as int?,
      userId: json['user_id'] as int,
      orderId: json['order_id'] as int,
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      fullName: json['full_name'],
      status: json['status'],
      shippingAddress: json['shipping_address'],
      total: double.parse(json['total'].toString()),
      createdAt: parsedDate,
    );
  }
}

class OrderItem {
  OrderItem({
    required this.itemId,
    required this.orderId,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.subtotal,
    required this.createdAt,
  });

  final int itemId;
  final int orderId;
  final int productId;
  final Product product;
  final int quantity;
  final double subtotal;
  final DateTime createdAt;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['item_id'] as int,
      orderId: json['order_id'] as int,
      productId: json['product_id'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      subtotal: double.parse(json['subtotal'].toString()),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
