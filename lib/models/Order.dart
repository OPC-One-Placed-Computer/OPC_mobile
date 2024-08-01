import 'package:opc_mobile_development/models/checkout.dart';

class Order {
  final int? id;
  final int? userId;
  final List<OrderItem>? orderItems;
  final String? fullName;
  final String? status;
  final String? selectedPaymentMethod;
  final String? shippingAddress;
  final double? total;
  final String? stripeSessionId;
  final DateTime? createdAt;

  Order({
    this.id,
    this.userId,
    this.orderItems,
    this.fullName,
    this.status,
    this.selectedPaymentMethod,
    this.shippingAddress,
    this.total,
    this.stripeSessionId,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.parse(json['created_at']);
    return Order(
      id: json['order_id'] as int?,
      userId: json['user_id'] as int?,
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      fullName: json['full_name'] as String?,
      status: json['status'] as String?,
      selectedPaymentMethod: json['payment_method'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      total: double.tryParse(json['total'].toString()),
      stripeSessionId: json['stripe_session_id'] as String?,
      createdAt: parsedDate,
    );
  }
}