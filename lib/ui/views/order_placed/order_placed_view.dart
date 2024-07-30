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
            toolbarHeight: 100,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Purchases',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        if (isDropdownVisible)
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: viewModel.selectedFilter,
                              items: <String>[
                                'All',
                                'Today',
                                'Last Week',
                                'Last Month'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(fontSize: 13.0),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  viewModel.setSelectedFilter(newValue!);
                                  isDropdownVisible = false;
                                });
                              },
                            ),
                          ),
                        IconButton(
                          icon: Icon(
                            isDropdownVisible
                                ? Icons.filter_alt_off
                                : Icons.filter_alt,
                          ),
                          onPressed: () {
                            setState(() {
                              isDropdownVisible = !isDropdownVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {},
                    child: AbsorbPointer(
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: GoogleFonts.poppins(fontSize: 13),
                        indicator: RRectIndicator(
                          color: Colors.blue,
                          radius: 20,
                          horizontalPadding: 6.0,
                          height: 3.0,
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
              buildOrderList(viewModel, ['pending']),
              buildOrderList(viewModel, ['paid', 'confirmed', 'shipped']),
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
      return statusFilters.any((statusFilter) => order.status
              .toLowerCase()
              .contains(statusFilter.toLowerCase())) &&
          viewModel.applyDateFilter(order.createdAt);
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
            final orderId = order.orderId;
            final status = order.status;

            Color dotColor;
            Color textColor;

            switch (status) {
              case 'paid':
              case 'confirmed':
              case 'shipped':
              case 'completed':
                dotColor = Colors.green;
                textColor = Colors.green;
                break;
              case 'pending':
                dotColor = Colors.orange;
                textColor = Colors.orange;
                break;
              case 'cancelled':
              case 'refunded':
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
                      onProductTapped: (Product value) {},
                    ),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 75.0),
                                child: Text(
                                  'Order ID: $orderId',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      color: dotColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    status,
                                    style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 13.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              DateFormat('dd-MM-yyyy hh:mm a')
                                  .format(createdAt),
                              style: GoogleFonts.poppins(
                                color: Colors.black54,
                                fontSize: 9,
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
                        color: Color.fromARGB(255, 30, 11, 72),
                        size: 48.0,
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
