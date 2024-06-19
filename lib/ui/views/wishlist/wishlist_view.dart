import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'wishlist_viewmodel.dart';

class WishlistView extends StackedView<WishlistViewModel> {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WishlistViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Wish List')),
    );
  }

  @override
  WishlistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WishlistViewModel();
}
