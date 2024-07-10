import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/models/current_authentication.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/models/update_user.dart';

abstract class ApiServiceService {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
  Future<Cart> addToCart(int productId, int quantity);
  Future<List<Cart>> getAllCartItems();
  Future<void> deleteFromCart(int cartId);
  Future<CurrentAuthentication> getCurrentAuthentication();
  Future<Checkout> checkOut(String fullName, String address, int total,
      List<Map<String, dynamic>> cartItems);
  Future<List<Checkout>> getOrdersDetails();
  Future<UpdateUser> updateUser(UpdateUser user);
  Future<UpdatePassword> updatePassword(UpdatePassword user);
}
