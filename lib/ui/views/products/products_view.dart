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
                      _buildHeader(),
                       const SizedBox(height: 20), 
                      _buildSearchBar(viewModel),
                      _buildFilters(viewModel),
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

  Widget _buildHeader() {
    return Container(
      height: 180,
      color: const Color.fromARGB(255, 19, 7, 46),
      alignment: Alignment.center,
      child: Transform.translate(
        offset: const Offset(0.0, -20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/resources/images/logo.png',
              height: 100,
              width: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome to One Pc Store',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            Text(
              'Where high quality products are in one place',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(ProductsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search products...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          viewModel.searchProducts(value);
        },
      ),
    );
  }

  Widget _buildFilters(ProductsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filtered by:',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: 0.8,
                  child: DropdownButton<String>(
                    value: viewModel.selectedCategory,
                    items: viewModel.categories
                        .map((String category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      viewModel.setSelectedCategory(newValue);
                    },
                    hint: const Text('Select Category'),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Opacity(
                  opacity: 0.8,
                  child: DropdownButton<String>(
                    value: viewModel.selectedBrand,
                    items: viewModel.brands
                        .map((String brand) => DropdownMenuItem<String>(
                              value: brand,
                              child: Text(
                                brand,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      viewModel.setSelectedBrand(newValue);
                    },
                    hint: const Text('Select Brand'),
                    isExpanded: true,
                  ),
                ),
              ),
            ],
          ),
        ],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8.0)),
                  child: CachedNetworkImage(
                    imageUrl: Constants.baseUrl + product.imagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.brand,
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        '\$ ${product.price.toString()}',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => onAddToCartTapped(product),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
