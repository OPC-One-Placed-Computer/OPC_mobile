import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/widgets/featured_product.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:stacked/stacked.dart';

import 'products_view_model.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProductsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250, // Adjust the height according to your needs
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        FeaturedProduct(
                            image: 'https://i.imgur.com/8UdKNS4.jpeg'),
                        FeaturedProduct(
                            image: 'https://i.imgur.com/8UdKNS4.jpeg'),
                        FeaturedProduct(
                            image: 'https://i.imgur.com/8UdKNS4.jpeg'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Featured Products',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Latest Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: viewModel.products.map((product) {
                          return ProductItem(
                            product: product,
                            onProductTapped: (product) => viewModel
                                .navigationService
                                .navigateTo(Routes.products_view,
                                    arguments: ProductdetailsViewArguments(
                                        product: product)),
                          );
                        }).toList()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Top Sale Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: viewModel.products.map((product) {
                          return ProductItem(
                            product: product,
                            onProductTapped: (value) => viewModel
                                .navigationService
                                .navigateTo(Routes.products_view,
                                    arguments: ProductdetailsViewArguments(
                                        product: product)),
                          );
                        }).toList()),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }

  @override
  ProductsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsViewModel();

  @override
  void onViewModelReady(ProductsViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onProductTapped;

  const ProductItem(
      {Key? key, required this.product, required this.onProductTapped})
      : super(key: key);

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
                ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: CachedNetworkImage(
                      imageUrl: Constants.baseUrl + product.imagePath,
                      height: 100,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(product.brand),
                      Text(
                        product.price.toString(),
                        style: const TextStyle(color: Colors.green),
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
                onPressed: () {
                  // onProductTapped.call(product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
