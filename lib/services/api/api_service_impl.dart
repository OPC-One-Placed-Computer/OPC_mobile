import 'package:dio/dio.dart';
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
}
