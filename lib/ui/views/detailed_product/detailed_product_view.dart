import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/widgets/my_circle_loading.dart';
import 'package:stacked/stacked.dart';

import 'detailed_product_viewmodel.dart';

class DetailedProductView extends StatelessWidget {
  const DetailedProductView({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailedProductViewModel>.reactive(
      viewModelBuilder: () => DetailedProductViewModel(product),
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
          backgroundColor: Colors.white,
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 16,
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
                      const SizedBox(height: 20),
                      Text(
                        'PRODUCT DETAILS',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
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
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageName;
  final Uint8List imageData;

  const ProductImage({
    Key? key,
    required this.imageName,
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
