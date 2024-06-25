import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/widgets/my_circle_loading.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:stacked/stacked.dart';

import 'productdetails_viewmodel.dart';

class ProductdetailsView extends StatelessWidget {
  const ProductdetailsView({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductdetailsViewModel>.reactive(
      viewModelBuilder: () => ProductdetailsViewModel(product),
      onViewModelReady: (model) => model.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Product Details',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 44, 45, 114),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: viewModel.isBusy
              ? const MyCircleLoading()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          viewModel.product.productName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl:
                                Constants.baseUrl + viewModel.product.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Brand Name : ${viewModel.product.brand}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Product details:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          viewModel.product.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Product price:',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text:
                                    ' \$ ${viewModel.product.price.toString()}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Quantity: ${viewModel.product.quantity.toString()}',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.shopping_cart),
                                  label: const Text('Add to Cart'),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
