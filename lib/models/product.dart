
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
