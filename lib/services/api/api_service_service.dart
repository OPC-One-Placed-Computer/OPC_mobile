import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';

abstract class ApiServiceService {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
  Future<Cart> addToCart(int productId, int quantity);
  Future<List<Cart>> getAllCartItems();
  Future<void> deleteFromCart(int cartId);
}
