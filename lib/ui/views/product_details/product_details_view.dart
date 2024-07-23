import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/widgets/my_circle_loading.dart';
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Product Details',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 7, 46),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: viewModel.isBusy
              ? const MyCircleLoading()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      viewModel.imageData == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Image.memory(
                              viewModel.imageData!,
                              fit: BoxFit.contain,
                            ),
                      const SizedBox(height: 20),
                      Text(
                        viewModel.product.productName,
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 21,
                          ),
                          children: [
                            const TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '\₱ ${viewModel.product.price.toString()}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'PRODUCT DETAILS',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Brand: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: viewModel.product.brand,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: viewModel.product.category,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Details',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel.product.description,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Available Quantity: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: viewModel.product.quantity.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Quantity: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                iconSize: 25,
                                icon: const Icon(Icons.remove_circle),
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: viewModel.decrementQuantity,
                              ),
                              Text(
                                '${viewModel.quantity}',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(
                                iconSize: 25,
                                icon: const Icon(Icons.add_circle),
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: viewModel.incrementQuantity,
                              ),
                            ],
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                -0.0, 0.0, 0.0), // Adjust the offset here
                            child: SizedBox(
                              width: 125,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 153),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: () async {
                                  viewModel.setBusy(true);
                                  try {
                                    await viewModel.addToCart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Product added to cart'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: $e'),
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: Color(0xFFD22630),
                                      ),
                                    );
                                  } finally {
                                    viewModel.setBusy(false);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imagePath;
  final Uint8List imageData;

  const ProductImage({
    Key? key,
    required this.imagePath,
    required this.imageData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      imageData,
      fit: BoxFit.cover,
    );
  }
}
