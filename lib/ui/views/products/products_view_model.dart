import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductsViewModel extends AppBaseViewModel {
  List<Product> products = [];
  List<Product> allProducts = [];

  String? selectedCategory;
  String? selectedBrand;
  List<String> categories = ['All'];
  List<String> brands = ['All'];

  void init() async {
    setBusy(true);
    await _getProducts();
    _initializeFilters();
    setBusy(false);
  }

  Future<void> _getProducts() async {
    allProducts = await apiService.getProducts();
    products = allProducts;
  }

  void _initializeFilters() {
    categories.addAll(allProducts.map((product) => product.category).toSet());
    brands.addAll(allProducts.map((product) => product.brand).toSet());
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all products based on selected filters
      filterProducts();
    } else {
      // Filter products based on both query and selected filters
      products = allProducts
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()) &&
              (selectedCategory == null ||
                  selectedCategory == 'All' ||
                  product.category == selectedCategory) &&
              (selectedBrand == null ||
                  selectedBrand == 'All' ||
                  product.brand == selectedBrand))
          .toList();
    }
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    selectedCategory = category;
    filterProducts();
    notifyListeners();
  }

  void setSelectedBrand(String? brand) {
    selectedBrand = brand;
    filterProducts();
    notifyListeners();
  }

  void filterProducts() {
    products = allProducts.where((product) {
      final categoryMatches = selectedCategory == null ||
          selectedCategory == 'All' ||
          product.category == selectedCategory;
      final brandMatches = selectedBrand == null ||
          selectedBrand == 'All' ||
          product.brand == selectedBrand;
      return categoryMatches && brandMatches;
    }).toList();
  }
}
