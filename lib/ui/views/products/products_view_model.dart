import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:opc_mobile_development/models/product.dart';

class ProductsViewModel extends AppBaseViewModel {
  List<Product> allProducts = [];
  List<Product> products = [];
  int currentPage = 1;
  int lastPage = 1;
  bool isLoadingMore = false;
  bool canLoadMore = true;
  bool get isLastPage => currentPage == lastPage;

  double? minPrice;
  double? maxPrice;

  String? selectedCategory;
  String? selectedBrand;
  List<String> categories = ['All'];
  List<String> brands = ['All'];
  int quantity = 1;
  bool _isButtonVisible = false;
  bool get isButtonVisible => _isButtonVisible;

  void toggleButtonVisibility(bool isVisible) {
    _isButtonVisible = isVisible;
    notifyListeners();
  }

  void init() async {
    setBusy(true);
    await _getProducts();
    _initializeFilters();
    setBusy(false);
  }

  Future<void> _getProducts({int page = 1}) async {
    try {
      print('Fetching products for page: $page');
      final paginatedProducts = await apiService.getProducts(page: page);
      if (page == 1) {
        allProducts = paginatedProducts.data;
      } else {
        allProducts.addAll(paginatedProducts.data);
      }
      products = allProducts;
      currentPage = paginatedProducts.currentPage;
      lastPage = paginatedProducts.lastPage;
      canLoadMore = currentPage < lastPage;
      print('Current Page: $currentPage, Last Page: $lastPage');
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void loadMoreProducts() async {
    if (currentPage < lastPage && !isLoadingMore) {
      print('Loading more products...');
      isLoadingMore = true;
      currentPage += 1;
      await _getProducts(page: currentPage);
    }
  }

  void debugPrintKeys(List<Product> products) {
    for (var product in products) {
      print('Product key: ${product.id}');
    }
  }

  void _initializeFilters() {
    categories.addAll(allProducts.map((product) => product.category).toSet());
    brands.addAll(allProducts.map((product) => product.brand).toSet());
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
        final matchesBrand =
            product.brand.toLowerCase().contains(lowerCaseQuery);

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
      final categoryMatches = selectedCategory == null ||
          selectedCategory == 'All' ||
          product.category == selectedCategory;
      final brandMatches = selectedBrand == null ||
          selectedBrand == 'All' ||
          product.brand == selectedBrand;
      final priceMatches = (minPrice == null || product.price >= minPrice!) &&
          (maxPrice == null || product.price <= maxPrice!);
      return categoryMatches && brandMatches && priceMatches;
    }).toList();
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    final user = await checkAuthentication();
    if (user == null) {
      return;
    }
    try {
      await apiService.addToCart(product.id!, quantity);
      snackbarService.showSnackbar(
          message: '${product.productName} added to cart');
    } catch (e) {
      print('Error: $e');
    }
  }
}
