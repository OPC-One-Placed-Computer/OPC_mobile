import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/cart.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/checkout/checkout_viewmodel.dart';
import 'package:opc_mobile_development/ui/views/product_details/product_details_view.dart';
import 'package:stacked/stacked.dart';

class CheckoutView extends StatelessWidget {
  final List<Cart> selectedCartItems;
  final ValueChanged<Product> onProductTapped;

  const CheckoutView({
    Key? key,
    required this.selectedCartItems,
    required this.onProductTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      viewModelBuilder: () => CheckoutViewModel(selectedCartItems),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (viewModel.loading) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'Checkout',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 19, 7, 46),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Checkout',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 19, 7, 46),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Information',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  viewModel.fullName ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 17,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: viewModel.isEditingAddress
                                    ? SizedBox(
                                        height: 26,
                                        child: TextFormField(
                                          initialValue:
                                              viewModel.tempAddress ?? '',
                                          onChanged: (value) {
                                            viewModel.tempAddress = value;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.only(
                                              top: 8,
                                              left: 5,
                                            ),
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                        ),
                                      )
                                    : Text(
                                        viewModel.address ?? '',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                        ),
                                      ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 19,
                                ),
                                onPressed: () {
                                  viewModel.toggleEditMode();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  color: Colors.black,
                                  size: 20.0,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  'Current Payment :',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0.0),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Radio<String>(
                                          value: 'cod',
                                          groupValue:
                                              viewModel.selectedPaymentMethod,
                                          onChanged: (String? value) {
                                            viewModel
                                                .updatePaymentMethod(value);
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Cash on Delivery',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: const Offset(0.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(-14.0, -20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Radio<String>(
                                    value: 'stripe',
                                    groupValue: viewModel.selectedPaymentMethod,
                                    onChanged: (String? value) {
                                      viewModel.updatePaymentMethod(value);
                                    },
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(-4.0, 0.0),
                                  child: Text(
                                    'Online Payment',
                                    style: GoogleFonts.poppins(fontSize: 13.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: viewModel.selectedCartItems.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.selectedCartItems[index];
                      final product = item.product;
                      return InkWell(
                        onTap: () => viewModel.navigationService.navigateTo(
                          Routes.detailed_product,
                          arguments:
                              DetailedProductViewArguments(product: product),
                        ),
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(10),
                          height: 137,
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
                              SizedBox(
                                width: 140,
                                height: 130,
                                child: FutureBuilder<Uint8List>(
                                  future: viewModel
                                      .fetchImageData(product.imageName),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
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
                                    const SizedBox(height: 29),
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Price: ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '₱ ${product.price.toString()}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Subtotal: ',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ' \₱ ${viewModel.getSubtotal(item).toStringAsFixed(2)}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 133,
                  padding: const EdgeInsets.all(20.0),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Transform.translate(
                            offset: const Offset(0, -10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Items',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${viewModel.totalItems}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Transform.translate(
                            offset: const Offset(0, -10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Amount',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$ ${viewModel.totalAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool confirm = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Confirm Order',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        content: Text(
                                          'Do you want to place the order?',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              'No',
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false;

                              if (confirm) {
                                await viewModel.placeOrder();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor:
                                  const Color.fromARGB(255, 19, 7, 46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Flexible(
                              child: Text(
                                'Place Order',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
