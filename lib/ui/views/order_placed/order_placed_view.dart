import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:opc_mobile_development/models/product.dart';
import 'package:opc_mobile_development/ui/views/order_placed/rrect_indicator.dart';
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart';
import 'package:stacked/stacked.dart';
import 'order_placed_viewmodel.dart';

class OrderPlacedView extends StatefulWidget {
  const OrderPlacedView({Key? key}) : super(key: key);

  @override
  _OrderPlacedViewState createState() => _OrderPlacedViewState();
}

class _OrderPlacedViewState extends State<OrderPlacedView> {
  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderPlacedViewModel>.reactive(
      viewModelBuilder: () => OrderPlacedViewModel(),
      onViewModelReady: (viewModel) => viewModel.fetchOrders(),
      builder: (context, viewModel, child) => DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    child: AbsorbPointer(
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: GoogleFonts.poppins(fontSize: 13),
                        indicator: RRectIndicator(
                          color: Colors.blue,
                          radius: 20,
                          horizontalPadding: 6.0,
                          height: 4.0,
                        ),
                        indicatorWeight: 0,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: const Color.fromARGB(255, 0, 0, 0),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('To Pay'),
                              ),
                            ),
                          ),
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('To Deliver'),
                              ),
                            ),
                          ),
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('To Receive'),
                              ),
                            ),
                          ),
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('Completed'),
                              ),
                            ),
                          ),
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('Cancelled'),
                              ),
                            ),
                          ),
                          Tab(
                            child: Transform.translate(
                              offset: const Offset(-60, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: const Text('Refunded'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildOrderList(viewModel, ['pending','awaiting payment']),
              buildOrderList(viewModel, [
                'paid',
                'confirmed',
                'shipped',
              ]),
              buildOrderList(viewModel, ['delivered']),
              buildOrderList(viewModel, ['completed']),
              buildOrderList(viewModel, ['cancelled']),
              buildOrderList(viewModel, ['refunded']),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderList(
      OrderPlacedViewModel viewModel, List<String> statusFilters,
      {String? additionalText}) {
    if (viewModel.isBusy && viewModel.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredOrders = viewModel.orders.where((order) {
      return statusFilters.any((statusFilter) =>
          order.status.toLowerCase().contains(statusFilter.toLowerCase()));
    }).toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
              child: Lottie.asset(
                'lib/resources/images/animation_2.json',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'No orders found.',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.refreshOrders();
      },
      color: Colors.blue,
      strokeWidth: 2.0,
      displacement: 20.0,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!viewModel.isBusy &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            viewModel.fetchOrders(loadMore: true);
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: filteredOrders.length + (viewModel.isBusy ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == filteredOrders.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final order = filteredOrders[index];
            final createdAt = order.createdAt;

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewOrderPlacedView(
                      orderItems: order.orderItems,
                      checkout: order,
                      onProductTapped: (Product value) {},
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 216, 216, 216),
                    width: 1.0,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              FutureBuilder<Uint8List>(
                                future: viewModel.fetchImageData(
                                    order.orderItems.first.product.imageName),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 80,
                                      color: Color.fromARGB(255, 220, 219, 219),
                                    );
                                  } else if (snapshot.hasData) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.contain,
                                      width: 100,
                                      height: 100,
                                    );
                                  } else {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 80,
                                      color: Colors.grey,
                                    );
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.orderItems
                                            .map((item) =>
                                                item.product?.productName ?? '')
                                            .join(', '),
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Total Amount: \₱ ${order.total.toStringAsFixed(2)}',
                                        style:
                                            GoogleFonts.poppins(fontSize: 10.0),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        'View more >',
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 200.0),
                            child: Text(
                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(createdAt),
                              style: GoogleFonts.poppins(fontSize: 10.0),
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
    );
  }
}
