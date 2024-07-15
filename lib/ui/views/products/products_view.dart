import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';

import 'products_view_model.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Products', style: GoogleFonts.poppins()),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
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
                      child: _FilterModalSheet(viewModel: viewModel),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: viewModel.isBusy && viewModel.products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!viewModel.isLoadingMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    viewModel.loadMoreProducts();
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      _buildProductList(viewModel),
                      if (viewModel.isLoadingMore)
                        const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildProductList(ProductsViewModel viewModel) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20.0,
      runSpacing: 20.0,
      children: viewModel.products.map((product) {
        return ProductItem(
          key: Key(product.id.toString()),
          product: product,
          onProductTapped: (product) => viewModel.navigationService.navigateTo(
            Routes.products_view,
            arguments: ProductdetailsViewArguments(product: product),
          ),
          onAddToCartTapped: (product) async {
            await viewModel.addToCart(product);
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              SnackBar(
                content: Text('${product.productName} added to cart'),
                backgroundColor: Colors.green,
              ),
            );
          },
        );
      }).toList(),
    );
  }
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
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
              _buildSearchBar(widget.viewModel),
              _buildFilters(widget.viewModel),
              _buildPriceRangeFilter(widget.viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(ProductsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
      ),
    );
  }

  Widget _buildFilters(ProductsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filtered by:',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: viewModel.selectedCategory,
                    items: viewModel.categories
                        .map((String category) => DropdownMenuItem<String>(
                              value: category,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  category,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        viewModel.setSelectedCategory(newValue);
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    isExpanded: true,
                    underline: Container(),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: viewModel.selectedBrand,
                    items: viewModel.brands
                        .map((String brand) => DropdownMenuItem<String>(
                              value: brand,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  brand,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        viewModel.setSelectedBrand(newValue);
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    hint: const Text(
                      'Select Brand',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    isExpanded: true,
                    underline: Container(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeFilter(ProductsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Price Range:',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: minPriceController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Minimum Price',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true, 
                        contentPadding: EdgeInsets.only(
                            top:
                                8.0),
                      ),
                      onChanged: (value) {
                        double? minPrice =
                            value.isNotEmpty ? double.tryParse(value) : null;
                        setState(() {
                          viewModel.setPriceRange(minPrice, viewModel.maxPrice);
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Maximum Price',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true, 
                        contentPadding: EdgeInsets.only(
                            top:
                                8.0),
                      ),
                      onChanged: (value) {
                        double? maxPrice =
                            value.isNotEmpty ? double.tryParse(value) : null;
                        setState(() {
                          viewModel.setPriceRange(viewModel.minPrice, maxPrice);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
                  child: CachedNetworkImage(
                    imageUrl: '${Constants.baseUrl}${product.imagePath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.productName,
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
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
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: () => onAddToCartTapped.call(product),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Color.fromARGB(255, 183, 120, 24),
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
