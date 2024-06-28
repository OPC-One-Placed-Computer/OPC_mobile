import 'package:dio/dio.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/helpers/dio_client.dart';

class ApiServiceImpl implements ApiServiceService {
  ApiServiceImpl({Dio? dio}) : _dio = dio ?? DioClient().instance;

  final Dio _dio;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      final productsData = response.data as Map<String, dynamic>;
      final List<Product> products = (productsData['data'] as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList();
      return products;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      final product = response.data as Map<String, dynamic>;
      final prod = Product.fromJson(product['data']);
      print(prod);
      return prod;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Cart> addCart() async {
    try {
      final response = await _dio.post('/cart');
      final product = response.data as Map<String, dynamic>;
      final cart = Cart.fromJson(product['data']);
      return cart;
    } catch (_) {
      rethrow;
    }
  }
}
