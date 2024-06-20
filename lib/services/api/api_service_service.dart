import 'package:opc_mobile_development/models/product.dart';

abstract interface class ApiServiceService {
  Future<List<Product>> getProducts();
}
