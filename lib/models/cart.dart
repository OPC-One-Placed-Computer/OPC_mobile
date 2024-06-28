import 'package:opc_mobile_development/models/product.dart';

class Cart {
  Cart({
    this.id,
    required this.userId,
    required this.productId,
    required this.product,
    required this.quantity,
    required this.subTotal,
  });
  final int? id;
  final int? userId;
  final int? productId;
  final Product product;
  final int quantity;
  final int subTotal;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['cart_id'],
        userId: json['user_id'],
        productId: json['product_id'],
        product: json['product'],
        quantity: json['quantity'],
        subTotal: json['subtotal'],
      );
      
}
