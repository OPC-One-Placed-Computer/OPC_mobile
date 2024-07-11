class Product {
  Product(
      {this.id,
      required this.imageName,
      required this.price,
      required this.brand,
      required this.productName,
      required this.category,
      required this.quantity,
      required this.description,
      required this.imagePath});
  final int? id;
  final String imageName;
  final double price;
  final String brand;
  final String imagePath;
  final String productName;
  final String category;
  final int quantity;
  final String description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['product_id'],
        imageName: json['image_name'],
        price: double.parse(json['price']),
        brand: json['brand'],
        productName: json['product_name'],
        category: json['category'],
        quantity: json['quantity'],
        description: json['description'],
        imagePath: json['image_path'],
      );
}

class PaginatedProducts {
  List<Product> data;
  int currentPage;
  int lastPage;

  PaginatedProducts({
    required this.data,
    required this.currentPage,
    required this.lastPage,
  });

  factory PaginatedProducts.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data']['data'] as List<dynamic>;
    return PaginatedProducts(
      data: dataJson.map((productJson) => Product.fromJson(productJson)).toList(),
      currentPage: json['data']['current_page'] ?? 1,
      lastPage: json['data']['last_page'] ?? 1,
    );
  }
}


