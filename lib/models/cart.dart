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
  final int productId;
  final Product product;
  int quantity;
  final double subTotal;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['cart_id'] as int?,
        userId: json['user_id'] as int?,
        productId: json['product_id'] as int,
        product: Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int,
        subTotal: double.parse(json['subtotal'].toString()),
      );
}
