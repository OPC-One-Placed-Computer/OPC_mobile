import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'order_placed_viewmodel.dart';

class OrderPlacedView extends StatelessWidget {
  const OrderPlacedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderPlacedViewModel>.reactive(
      viewModelBuilder: () => OrderPlacedViewModel(),
      onViewModelReady: (viewModel) => viewModel.fetchOrders(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Placed Orders',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 7, 46),
        ),
        body: viewModel.isBusy && viewModel.orders.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : viewModel.orders.isEmpty
                ? Center(
                    child: Text(
                      'No orders found.',
                      style: GoogleFonts.poppins(),
                    ),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!viewModel.isBusy &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        viewModel.fetchOrders(loadMore: true);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: viewModel.orders.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.orders.length) {
                          return viewModel.isBusy
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }

                        final order = viewModel.orders[index];
                        final createdAt = order.createdAt;
                        final orderId = order.orderId;
                        final status = order.status;

                        Color dotColor;
                        Color textColor;

                        switch (status) {
                          case 'paid':
                            dotColor = Colors.green;
                            textColor = Colors.green;
                            break;
                          case 'pending':
                            dotColor = Colors.orange;
                            textColor = Colors.orange;
                            break;
                          case 'cancelled':
                            dotColor = Colors.red;
                            textColor = Colors.red;
                            break;
                          default:
                            dotColor = Colors.grey;
                            textColor = Colors.black;
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ViewOrderPlacedView(
                                  orderItems: order.orderItems,
                                  checkout: order,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 75.0),
                                            child: Text(
                                              'Order ID: $orderId',
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8.0),
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: dotColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                status,
                                                style: GoogleFonts.poppins(
                                                  color: textColor,
                                                  fontSize: 10,
                                                  //     fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20.0),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          DateFormat.yMMMMd().format(createdAt),
                                          style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  top: 3.0,
                                  left: 16.0,
                                  child: Icon(
                                    Icons.shopping_bag_sharp,
                                    color: Colors.blue,
                                    size: 60.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
