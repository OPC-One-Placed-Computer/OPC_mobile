import 'dart:typed_data';

import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/models/current_authentication.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/models/update_user.dart';

abstract class ApiServiceService {
  Future<PaginatedProducts> getProducts({int page = 1});
  Future<Product> getProduct(String id);
  Future<Cart> addToCart(int productId, int quantity);
  Future<List<Cart>> getAllCartItems();
  Future<void> deleteFromCart(int cartId);
  Future<CurrentAuthentication> getCurrentAuthentication();
  Future<Checkout> checkOut(
    String fullName,
    String address,
    String selectedPaymentMethod,
    int total,
    List<String> cartItems,
  );
  Future<List<Checkout>> getOrdersDetails(
      {required int page, required int pageSize});
  Future<UpdateUser> updateUser(UpdateUser user, Uint8List? imageBytes);
  Future<UpdatePassword> updatePassword(UpdatePassword user);
  Future<Uint8List> retrieveProfileImage(String filename);
  Future<Uint8List> retrieveProductImage(String path);

  Future<void> canceledOrder(int orderId);
  Future<String> getPaymentLink(
    String fullName,
    String address,
    String selectedPaymentMethod,
    int total,
    List<String> cartItems,
  );
  Future<void> updateQuantity(int productId, int quantity);
  Future<String> getSessionStripe(String sessionId);
}
