import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opc_mobile_development/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          title: const Text(
            'Orders Placed',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 19, 7, 46),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : viewModel.orders.isEmpty
                ? const Center(
                    child: Text('No orders found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    itemCount: viewModel.orders.length,
                    itemBuilder: (context, index) {
                      final order = viewModel.orders[index];
                      final createdAt = order.createdAt;
                      final orderId = order.orderId;
                      final isExpanded =
                          viewModel.expandedOrders[orderId] ?? false;

                    
                      final totalProducts = order.orderItems.length;
                      final totalPrice = order.orderItems.fold<double>(
                          0.0, (sum, item) => sum + item.subtotal);

                      return GestureDetector(
                        onTap: () => orderId != null
                            ? viewModel.toggleOrderExpansion(orderId)
                            : null,
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Order ID: $orderId'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Full Name: ${order.fullName}'),
                                    Text('Address: ${order.shippingAddress}'),
                                    Text(
                                        'Placed: ${DateFormat.yMMMMd().format(createdAt)}'),
                                    Text('Status: ${order.status}'),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: isExpanded ? null : 0.0,
                                child: isExpanded
                                    ? Container(
                                        padding: const EdgeInsets.all(10.0),
                                        color: Colors.grey[200],
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...order.orderItems.map((item) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            Constants.baseUrl +
                                                                item.product
                                                                    .imagePath,
                                                        fit: BoxFit.contain,
                                                        placeholder: (context,
                                                                url) =>
                                                            const Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    Text(
                                                      item.product.productName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                        'Quantity: ${item.quantity}'),
                                                    Text(
                                                        'Subtotal: ${item.subtotal}'),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            const SizedBox(height: 16.0),
                                            const Text(
                                              'Order Summary',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(
                                                'Total Products: $totalProducts'),
                                            Text('Total Price: \$$totalPrice'),
                                            const SizedBox(height: 16.0),
                                            ElevatedButton(
                                              onPressed: () {
                                               
                                                // viewModel.cancelOrder(orderId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                              ),
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      )
                                    : null,
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
