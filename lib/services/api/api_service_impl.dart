import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/models/current_authentication.dart';
import 'package:opc_mobile_development/models/update_user.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/services/helpers/dio_client.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service_impl.dart';

class ApiServiceImpl implements ApiServiceService {
  ApiServiceImpl({Dio? dio}) : _dio = dio ?? DioClient().instance;

  final Dio _dio;
  final SharedPreferenceServiceImpl _sharedPreferenceService =
      SharedPreferenceServiceImpl();

  @override
  Future<PaginatedProducts> getProducts({int page = 1}) async {
    try {
      final response =
          await _dio.get('/products', queryParameters: {'page': page});
      if (response.statusCode == 200) {
        final productsData = response.data as Map<String, dynamic>;
        return PaginatedProducts.fromJson(productsData);
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  Future<PaginatedProducts> getProductsByPriceRange({
    required int minPrice,
    required int maxPrice,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {
          'min_price': minPrice,
          'max_price': maxPrice,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        final productsData = response.data as Map<String, dynamic>;
        return PaginatedProducts.fromJson(productsData);
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
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/cart/$productId',
        data: {
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Quantity updated successfully.');
      } else {
        throw Exception('Failed to update quantity: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating quantity: $e');
      throw Exception('Error updating quantity: $e');
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
        '/current/authentication',
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

  @override
  Future<Checkout> checkOut(
    String fullName,
    String address,
    String selectedPaymentMethod,
    int total,
    List<String> cartItems,
  ) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/orders',
        data: {
          'full_name': fullName,
          'shipping_address': address,
          'total': total.toString(),
          'payment_method': selectedPaymentMethod,
          'cart_items': {
            'id': cartItems,
          },
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
          final checkout =
              Checkout.fromJson(cartData['data'] as Map<String, dynamic>);
          print('Order placed successfully: $checkout');
          return checkout;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to place order: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error placing order: $e');
      throw Exception('Error placing order: $e');
    }
  }

  @override
  Future<List<Checkout>> getOrdersDetails(
      {int page = 1, int pageSize = 10}) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        '/orders',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data['data']['data'] as List<dynamic>;
        print('Response Data: $responseData');

        final List<Checkout> orders =
            responseData.map((order) => Checkout.fromJson(order)).toList();
        print('Parsed Orders: $orders');

        return orders;
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }

  @override
  Future<UpdateUser> updateUser(UpdateUser user, Uint8List? imageBytes) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      FormData formData = FormData.fromMap({
        'email': user.email,
        'first_name': user.firstName,
        'last_name': user.lastName,
        'address': user.address,
        'image_name': user.imageName,
      });

      if (imageBytes != null) {
        formData.files.add(MapEntry(
          'image',
          MultipartFile.fromBytes(imageBytes, filename: user.imageName),
        ));
      }

      final response = await _dio.post(
        '/user/update/${user.id}',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        if (response.data is Map<String, dynamic>) {
          return UpdateUser.fromJson(response.data);
        } else {
          throw Exception('Invalid response data format');
        }
      } else {
        throw Exception(
            'Failed to update user: ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  @override
  Future<UpdatePassword> updatePassword(UpdatePassword user) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/user/update/${user.id}',
        data: {
          'email': user.email,
          'first_name': user.firstName,
          'last_name': user.lastName,
          'address': user.address,
          'old_password': user.oldPassword,
          'new_password': user.newPassword,
          'new_password_confirmation': user.newPasswordConfirmation,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
        if (response.data is Map<String, dynamic>) {
          return UpdatePassword.fromJson(response.data);
        } else {
          throw Exception('Invalid response data format');
        }
      } else {
        throw Exception(
            'Failed to update user: ${response.statusCode} ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final errorMessage =
            e.response?.data['message'] ?? 'Unknown error occurred';
        throw Exception(errorMessage);
      } else {
        throw Exception('Error updating user: ${e.message}');
      }
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  @override
  Future<Uint8List> retrieveProfileImage(String path) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.get(
        '/download/user-image',
        queryParameters: {'image_name': path},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to download profile image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading profile image: $e');
      rethrow;
    }
  }

  @override
  Future<Uint8List> retrieveProductImage(String path) async {
    try {
      final response = await _dio.get(
        '/download/product-image',
        queryParameters: {'image_name': path},
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to download product image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading product image: $e');
      rethrow;
    }
  }



  @override
  Future<void> canceledOrder(int orderId) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/orders/cancel',
        data: {
          'order_id': orderId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        print('Order canceled successfully');
      } else {
        throw Exception('Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error canceling order: $e');
      rethrow;
    }
  }

  @override
  Future<String> getPaymentLink(
    String fullName,
    String address,
    String selectedPaymentMethod,
    int total,
    List<String> cartItems,
  ) async {
    try {
      final token = await _sharedPreferenceService.getToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await _dio.post(
        '/orders',
        data: {
          'full_name': fullName,
          'shipping_address': address,
          'total': total.toString(),
          'payment_method': selectedPaymentMethod,
          'cancel_url': 'https://order.cancel',
          'cart_items': {
            'id': cartItems,
          },
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          final link = data['data']['url'];
          return link;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to place order: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (_) {
      rethrow;
    }
  }


}
