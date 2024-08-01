import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/models/Order.dart';
import 'package:opc_mobile_development/models/checkout.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:stacked/stacked.dart';

import 'view_order_placed_viewmodel.dart';

class ViewOrderPlacedView extends StackedView<ViewOrderPlacedViewModel> {
  final List<OrderItem> orderItems;
  final Order order;
  final ValueChanged<Product> onProductTapped;

  const ViewOrderPlacedView({
    Key? key,
    required this.orderItems,
    required this.order,
    required this.onProductTapped,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ViewOrderPlacedViewModel viewModel,
    Widget? child,
  ) {
    final totalProducts = orderItems.length;
    final totalPrice =
        orderItems.fold<double>(0, (sum, item) => sum + item.subtotal);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 7, 46),
      ),
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 242, 241, 241),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View Ordered Items',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                viewModel.isProductsVisible
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                              onPressed: () {
                                viewModel.toggleVisibility();
                              },
                            ),
                          ],
                        ),
                        if (viewModel.isProductsVisible)
                          ...orderItems.map((item) {
                            final product = item.product;
                            return InkWell(
                              onTap: () =>
                                  viewModel.navigationService.navigateTo(
                                Routes.detailed_product,
                                arguments: DetailedProductViewArguments(
                                    product: product),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 224, 224, 224),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<Uint8List>(
                                      future: viewModel
                                          .fetchImageData(product.imageName),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox(
                                            width: double.infinity,
                                            height: 100,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 100,
                                            color: Color.fromARGB(
                                                255, 220, 219, 219),
                                          );
                                        } else if (snapshot.hasData) {
                                          return Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                          );
                                        } else {
                                          return const Icon(
                                            Icons.broken_image,
                                            size: 100,
                                            color: Colors.grey,
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      product.productName,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      '₱ ${item.product.price}',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    Text(
                                      'Subtotal: ₱ ${item.subtotal}',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        const SizedBox(height: 10.0),
                        Text(
                          'Order Details',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 7.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Order Number: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 68.0),
                                child: Text(
                                  '# ${order.id}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Order From:',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Text(
                                  'One Place Computer',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Ordered Date: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Text(
                                  DateFormat('d-M-yyyy')
                                      .format(order.createdAt!),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Payment Method: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  order.selectedPaymentMethod!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Order Status: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Text(
                                  order.status!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Name: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 94.0),
                                child: Text(
                                  order.fullName!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Delivery Address: ',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: Text(
                                  order.shippingAddress!,
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'Total Ordered Items: ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        '$totalProducts',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'Total Price: ',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 86.0),
                                      child: Text(
                                        '₱ $totalPrice',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: order.status == 'pending' ||
                                  order.status == 'paid' ||
                                  order.status == 'awaiting payment',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1.0,
                                  ),
                                  const SizedBox(height: 5.0),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool? confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Confirm Cancellation'),
                                              content: const Text(
                                                  'Are you sure you want to cancel the order?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm == true) {
                                          await viewModel.cancelOrder(
                                              orderItems.first.orderId);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Order Cancelled Successfully',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor: Colors.green,
                                              duration:
                                                  const Duration(seconds: 1),
                                            ),
                                          );

                                          await Future.delayed(
                                              const Duration(seconds: 2));

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(100, 30),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: order.status == 'awaiting payment',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5.0),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool? confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Confirm Cancellation'),
                                              content: const Text(
                                                  'Are you sure you want to Pay the order?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm == true) {
                                          await viewModel
                                              .openStripeForm(order);
                                     
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 42, 29, 136),
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(100, 30),
                                      ),
                                      child: Text(
                                        'Pay',
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  @override
  ViewOrderPlacedViewModel viewModelBuilder(BuildContext context) =>
      ViewOrderPlacedViewModel(orderItems);
}
