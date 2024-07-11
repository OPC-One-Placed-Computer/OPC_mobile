import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/checkout/checkout_view.dart';
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

        double selectedSubtotal = viewModel.cartItems.fold(0.0, (sum, item) {
          if (viewModel.selectedIndices.contains(viewModel.cartItems.indexOf(item))) {
            return sum + (item.product.price * item.quantity);
          }
          return sum;
        });

        double selectedTotal = selectedSubtotal;

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
                      '(${viewModel.cartItems.length})',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        viewModel.isAllSelected ? Icons.close : Icons.check_circle,
                        color: viewModel.isAllSelected ? Colors.red : Colors.green,
                      ),
                      onPressed: () {
                        viewModel.toggleSelectAllItems();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        viewModel.deleteSelectedItems();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.cartItems[index];
                    final product = item.product;
                    return ProductItem(
                      product: product,
                      onProductTapped: (product) => viewModel.navigateToProductDetails(product),
                      viewModel: viewModel,
                      index: index,
                    );
                  },
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '\$${selectedSubtotal.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Cost',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                            ),
                          ),
                          const Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${selectedTotal.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (viewModel.selectedIndices.isEmpty) {
                        
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Select products to checkout'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            } else {
                              
                              final selectedCartItems = viewModel.getSelectedCartItems();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutView(
                                    selectedCartItems: selectedCartItems,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color.fromARGB(255, 19, 7, 46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Check Out Now',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
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

class ProductItem extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onProductTapped;
  final AddToCartViewModel viewModel;
  final int index;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onProductTapped,
    required this.viewModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onProductTapped.call(product),
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: viewModel.selectedIndices.contains(index),
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
                imageUrl: Constants.baseUrl + product.imagePath,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    'Price: \$${product.price.toString()}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                    ),
                  ),
                  
                  Text(
                    'Quantity: ${viewModel.cartItems[index].quantity.toString()}',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                    ),
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        iconSize: 20,
                        onPressed: () {
                          viewModel.decrementQuantity(index);
                        },
                      ),
                      Text(
                        viewModel.cartItems[index].quantity.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        iconSize: 20,
                        onPressed: () {
                          viewModel.incrementQuantity(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}