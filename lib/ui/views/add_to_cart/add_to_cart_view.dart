import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'add_to_cart_viewmodel.dart';

class AddToCartView extends StatelessWidget {
  const AddToCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddToCartViewModel>.reactive(
      viewModelBuilder: () => AddToCartViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 15.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: Row(
                  children: [
                    Text(
                      'Shopping Cart',
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${viewModel.totalItems})',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        viewModel.deleteSelectedItems();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.cartItems[index];
                    final product = item.product;
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value:
                                    viewModel.selectedIndices.contains(index),
                                onChanged: (value) {
                                  viewModel.toggleCheckbox(index);
                                },
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 100,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      Constants.baseUrl + product.imagePath,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Price: ${product.price.toString()}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          iconSize: 13,
                                          icon: const Icon(Icons.remove_circle),
                                          onPressed: () {
                                            viewModel.decrementQuantity();
                                          },
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                          ),
                                        ),
                                        IconButton(
                                          iconSize: 13,
                                          icon: const Icon(Icons.add_circle),
                                          onPressed: () {
                                            viewModel.incrementQuantity();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total Item(s)',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${viewModel.totalItems}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '\$${viewModel.subtotal.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '\$10.00',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${viewModel.total.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.navigationService
                                  .navigateTo(Routes.place_order);
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart),
                                const SizedBox(width: 4),
                                Text(
                                  'Check Out',
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
