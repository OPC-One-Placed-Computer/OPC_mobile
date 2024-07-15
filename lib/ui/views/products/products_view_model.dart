import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductsViewModel extends AppBaseViewModel {
  List<Product> allProducts = [];
  List<Product> products = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;
  double? minPrice;
  double? maxPrice;

  String? selectedCategory;
  String? selectedBrand;
  List<String> categories = ['All'];
  List<String> brands = ['All'];
  int quantity = 1;

  void init() async {
    setBusy(true);
    await _getProducts();
    _initializeFilters();
    setBusy(false);
  }

  Future<void> _getProducts({int page = 1}) async {
    try {
      final paginatedProducts = await apiService.getProducts(page: page);
      if (page == 1) {
        allProducts = paginatedProducts.data;
      } else {
        allProducts.addAll(paginatedProducts.data);
      }
      products = allProducts;
      currentPage = paginatedProducts.currentPage;
      lastPage = paginatedProducts.lastPage;
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setBusy(false);
    }
  }

  void _initializeFilters() {
    categories.addAll(allProducts.map((product) => product.category).toSet());
    brands.addAll(allProducts.map((product) => product.brand).toSet());
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || currentPage >= lastPage) return;

    isLoadingMore = true;
    currentPage++;
    await _getProducts(page: currentPage);
    isLoadingMore = false;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filterProducts();
    } else {
      products = allProducts.where((product) {
        final lowerCaseQuery = query.toLowerCase();
        final matchesProductName =
            product.productName.toLowerCase().contains(lowerCaseQuery);
        final matchesDescription =
            product.description.toLowerCase().contains(lowerCaseQuery);
        final matchesCategory =
            product.category.toLowerCase().contains(lowerCaseQuery);
        final matchesBrand = product.brand.toLowerCase().contains(lowerCaseQuery);

        return (matchesProductName ||
                matchesDescription ||
                matchesCategory ||
                matchesBrand) &&
            (selectedCategory == null ||
                selectedCategory == 'All' ||
                product.category == selectedCategory) &&
            (selectedBrand == null ||
                selectedBrand == 'All' ||
                product.brand == selectedBrand) &&
            (minPrice == null || product.price >= minPrice!) &&
            (maxPrice == null || product.price <= maxPrice!);
      }).toList();
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

  void setPriceRange(double? min, double? max) {
    minPrice = min;
    maxPrice = max;
    filterProducts();
    notifyListeners();
  }

  void filterProducts() {
    products = allProducts.where((product) {
      final categoryMatches =
          selectedCategory == null || selectedCategory == 'All' || product.category == selectedCategory;
      final brandMatches =
          selectedBrand == null || selectedBrand == 'All' || product.brand == selectedBrand;
      final priceMatches = (minPrice == null || product.price >= minPrice!) &&
          (maxPrice == null || product.price <= maxPrice!);
      return categoryMatches && brandMatches && priceMatches;
    }).toList();
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    try {
      await apiService.addToCart(product.id!, quantity);
      print('Product added to cart successfully');
    } catch (e) {
      print('Error: $e');
    }
  }
}
