import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'store_viewmodel.dart';

class StoreView extends StackedView<StoreViewModel> {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StoreViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Store')),
    );
  }

  @override
  StoreViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StoreViewModel();
}
