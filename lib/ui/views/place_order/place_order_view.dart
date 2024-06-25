import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'place_order_viewmodel.dart';

class PlaceOrderView extends StackedView<PlaceOrderViewModel> {
  const PlaceOrderView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlaceOrderViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Place Order Products ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 45, 114),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(child: Text('Store')),
    );
  }

  @override
  PlaceOrderViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlaceOrderViewModel();
}
