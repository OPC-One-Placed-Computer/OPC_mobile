import 'package:dio/dio.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/models/current_authentication.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/helpers/dio_client.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service_impl.dart';

class ApiServiceImpl implements ApiServiceService {
  ApiServiceImpl({Dio? dio}) : _dio = dio ?? DioClient().instance;

  final Dio _dio;
  final SharedPreferenceServiceImpl _sharedPreferenceService =
      SharedPreferenceServiceImpl();

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        final productsData = response.data as Map<String, dynamic>;
        final List<Product> products = (productsData['data'] as List<dynamic>)
            .map((product) => Product.fromJson(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      if (response.statusCode == 200) {
        final product = response.data as Map<String, dynamic>;
        final prod = Product.fromJson(product['data'] as Map<String, dynamic>);
        print('Product fetched successfully: $prod');
        return prod;
      } else {
        throw Exception('Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product: $e');
      rethrow;
    }
  }

  @override
  Future<Cart> addToCart(int productId, int quantity) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/cart',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final cartData = response.data as Map<String, dynamic>;
          final cart = Cart.fromJson(cartData['data'] as Map<String, dynamic>);
          print('Product added to cart successfully: $cart');
          return cart;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to add product to cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding to cart: $e');
      throw Exception('Error adding to cart: $e');
    }
  }

  @override
  Future<List<Cart>> getAllCartItems() async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        '/cart',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> cartData = responseData['data'] as List<dynamic>;
        final List<Cart> carts = cartData
            .map((cart) => Cart.fromJson(cart as Map<String, dynamic>))
            .toList();
        return carts;
      } else {
        throw Exception('Failed to fetch cart items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cart items: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteFromCart(int cartId) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.delete(
        '/cart/$cartId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Product removed from cart successfully');
      } else {
        throw Exception(
            'Failed to remove product from cart: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing product from cart: $e');
      rethrow;
    }
  }

  @override
  Future<CurrentAuthentication> getCurrentAuthentication() async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        '/current-authentication',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final currentAuth = CurrentAuthentication.fromJson(
            responseData['data'] as Map<String, dynamic>);
        print('Current authentication fetched successfully: $currentAuth');
        return currentAuth;
      } else {
        throw Exception(
            'Failed to fetch current authentication: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching current authentication: $e');
      rethrow;
    }
  }
}
