import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_viewmodel.dart';
import 'package:opc_mobile_development/ui/views/product_details/product_details_view.dart';
import 'package:stacked/stacked.dart';

import 'products_view_model.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 7, 46),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 8, 8, 8).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Expanded(
                    child: _buildSearchBar(viewModel),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black54,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 80),
                              child: _FilterModalSheet(viewModel: viewModel),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: viewModel.isBusy && viewModel.products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!viewModel.isLoadingMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    print('Reached end of the list');
                    viewModel.loadMoreProducts();
                  }
                  return false;
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          _buildProductList(context, viewModel),
                          if (viewModel.isLoadingMore)
                            const Center(child: CircularProgressIndicator()),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Visibility(
                        visible:
                            viewModel.isLastPage && !viewModel.isLoadingMore,
                        child: FloatingActionButton(
                          onPressed: () {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            );
                          },
                          backgroundColor: Colors.blue,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSearchBar(ProductsViewModel viewModel) {
    return Container(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 20),
          hintText: 'Search products...',
          hintStyle: GoogleFonts.poppins(fontSize: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 249, 249),
          contentPadding: const EdgeInsets.fromLTRB(12, 27, 12, 10),
        ),
        onChanged: (value) {
          viewModel.searchProducts(value);
        },
      ),
    );
  }
}

Widget _buildProductList(BuildContext context, ProductsViewModel viewModel) {
  return Wrap(
    alignment: WrapAlignment.center,
    spacing: 20.0,
    runSpacing: 20.0,
    children: List.generate(viewModel.products.length, (index) {
      final product = viewModel.products[index];
      return ProductItem(
        key: Key('${product.id}_$index'),
        product: product,
        onProductTapped: (product) => viewModel.navigationService.navigateTo(
          Routes.products_view,
          arguments: ProductdetailsViewArguments(product: product),
        ),
        onAddToCartTapped: (product) async {
          await viewModel.addToCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.productName} added to cart'),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    }),
  );
}

class _FilterModalSheet extends StatefulWidget {
  final ProductsViewModel viewModel;

  const _FilterModalSheet({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<_FilterModalSheet> createState() => _FilterModalSheetState();
}

class _FilterModalSheetState extends State<_FilterModalSheet> {
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;

  @override
  void initState() {
    super.initState();
    minPriceController = TextEditingController(
      text: widget.viewModel.minPrice?.toString() ?? '',
    );
    maxPriceController = TextEditingController(
      text: widget.viewModel.maxPrice?.toString() ?? '',
    );

    minPriceController.addListener(_onMinPriceChanged);
    maxPriceController.addListener(_onMaxPriceChanged);
  }

  @override
  void dispose() {
    minPriceController.removeListener(_onMinPriceChanged);
    maxPriceController.removeListener(_onMaxPriceChanged);
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  void _onMinPriceChanged() {
    double? minPrice = minPriceController.text.isNotEmpty
        ? double.tryParse(minPriceController.text)
        : null;
    widget.viewModel.setPriceRange(minPrice, widget.viewModel.maxPrice);
  }

  void _onMaxPriceChanged() {
    double? maxPrice = maxPriceController.text.isNotEmpty
        ? double.tryParse(maxPriceController.text)
        : null;
    widget.viewModel.setPriceRange(widget.viewModel.minPrice, maxPrice);
  }

  void _clearFilters() {
    setState(() {
      minPriceController.clear();
      maxPriceController.clear();
      widget.viewModel.setSelectedCategory(null);
      widget.viewModel.setSelectedBrand(null);
      widget.viewModel.setPriceRange(null, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Products',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                _buildFilters(widget.viewModel),
                const SizedBox(height: 8.0),
                _buildPriceRangeFilter(widget.viewModel),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _clearFilters,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 19, 7, 46),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      textStyle: GoogleFonts.poppins(fontSize: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size(64, 32),
                    ),
                    child: const Text('Clear Filters'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(ProductsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFilterDropdown(
          'Category',
          viewModel.categories,
          viewModel.selectedCategory,
          (category) => viewModel.setSelectedCategory(category),
        ),
        const SizedBox(height: 16.0),
        _buildFilterDropdown(
          'Brand',
          viewModel.brands,
          viewModel.selectedBrand,
          (brand) => viewModel.setSelectedBrand(brand),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown<T>(String label, List<T> items, T? selectedItem,
      ValueChanged<T?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        const SizedBox(height: 4.0),
        DropdownButtonFormField<T>(
          value: selectedItem,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeFilter(ProductsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Price Range',
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Min Price',
                  hintStyle: GoogleFonts.poppins(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text('-'),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Max Price',
                  hintStyle: GoogleFonts.poppins(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onProductTapped;
  final ValueChanged<Product> onAddToCartTapped;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onProductTapped,
    required this.onAddToCartTapped,
  }) : super(key: key);

  Future<Uint8List> fetchImageData(String imageName) async {
    final cachedImage = imageCacheService.getImage(imageName);
    if (cachedImage != null) {
      return cachedImage;
    }

    final imageData = await ApiServiceImpl().retrieveProductImage(imageName);

    imageCacheService.setImage(imageName, imageData);

    return imageData;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductTapped.call(product),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: FutureBuilder<Uint8List>(
                    future: fetchImageData(product.imageName),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ProductImage(
                          imageName: product.imageName,
                          imageData: snapshot.data!,
                        );
                      } else {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.productName,
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product.brand,
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 85, 85, 85),
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\₱ ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: () => onAddToCartTapped.call(product),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Color.fromARGB(255, 19, 7, 46),
                    size: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
