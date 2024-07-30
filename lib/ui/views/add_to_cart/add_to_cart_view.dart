import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/ui/views/checkout/checkout_view.dart';
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_viewmodel.dart';
import 'package:opc_mobile_development/ui/views/product_details/product_details_view.dart';
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
        if (viewModel.isBusy && viewModel.cartItems.isEmpty) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 19, 7, 46),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 8, 8, 8).withOpacity(0.5),
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
                      Text(
                        'Cart Items',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        double selectedSubtotal = viewModel.cartItems.fold(0.0, (sum, item) {
          if (viewModel.selectedIndices
              .contains(viewModel.cartItems.indexOf(item))) {
            return sum + (item.product.price * item.quantity);
          }
          return sum;
        });

        double selectedTotal = selectedSubtotal;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 0),
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
                    Text(
                      'Cart Items',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${viewModel.cartItems.length}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      viewModel.isAllSelected
                          ? Icons.close
                          : Icons.check_circle,
                      color: viewModel.isAllSelected
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      viewModel.toggleSelectAllItems();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: viewModel.selectedIndices.isEmpty
                          ? Colors.grey
                          : Colors.red,
                    ),
                    onPressed: viewModel.selectedIndices.isEmpty
                        ? null
                        : () {
                            viewModel.deleteSelectedItems();
                          },
                  ),
                ],
              ),
            ),
          ),
          body: viewModel.cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Lottie.asset(
                          'lib/resources/images/animation_3.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'No items in the cart',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 2),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.cartItems[index];
                          final product = item.product;
                          return ProductItem(
                            product: product,
                            onProductTapped: (product) =>
                                viewModel.navigationService.navigateTo(
                              Routes.detailed_product,
                              arguments: DetailedProductViewArguments(
                                  product: product),
                            ),
                            viewModel: viewModel,
                            index: index,
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 129,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cart Selected',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  '${viewModel.selectedIndices.length}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
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
                                  '\₱ ${selectedTotal.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (viewModel.selectedIndices.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Select products to checkout'),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                  } else {
                                    final selectedCartItems =
                                        viewModel.getSelectedCartItems();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckoutView(
                                          selectedCartItems: selectedCartItems,
                                          onProductTapped: (Product value) {},
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor:
                                      const Color.fromARGB(255, 19, 7, 46),
                                  // backgroundColor:
                                  //     const Color.fromARGB(255, 0, 0, 153),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'Check Out',
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

class ProductItem extends StatefulWidget {
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
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Future<Uint8List> imageDataFuture;

  @override
  void initState() {
    super.initState();
    imageDataFuture = fetchImageData(widget.product.imageName);
  }

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
      onTap: () => widget.onProductTapped.call(widget.product),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: EdgeInsets.zero,
        height: 125,
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
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: widget.viewModel.selectedIndices.contains(widget.index),
                onChanged: (value) {
                  setState(() {
                    widget.viewModel.toggleCheckbox(widget.index);
                  });
                },
              ),
              SizedBox(
                width: 130,
                height: 115,
                child: FutureBuilder<Uint8List>(
                  future: imageDataFuture,
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
                        imageName: widget.product.imageName,
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
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 5),
                      child: Text(
                        widget.product.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.product.brand,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Price: ',
                            ),
                            const TextSpan(
                              text: '\₱ ',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: widget.product.price.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Transform.translate(
                        offset: const Offset(0, 8),
                        child: Row(
                          children: [
                            Transform.translate(
                              offset: const Offset(0, -1),
                              child: Text(
                                'Quantity',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              iconSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                              onPressed: () {
                                setState(() {
                                  widget.viewModel
                                      .decrementQuantity(widget.index);
                                });
                              },
                            ),
                            Transform.translate(
                              offset: const Offset(-6, 0),
                              child: Text(
                                widget
                                    .viewModel.cartItems[widget.index].quantity
                                    .toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(-10, 0),
                              child: IconButton(
                                icon: const Icon(Icons.add_circle),
                                iconSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: () {
                                  setState(() {
                                    widget.viewModel
                                        .incrementQuantity(widget.index);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
