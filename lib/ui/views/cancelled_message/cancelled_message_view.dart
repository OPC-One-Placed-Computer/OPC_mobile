import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cancelled_message_viewmodel.dart';

class CancelledMessageView extends StackedView<CancelledMessageViewModel> {
  const CancelledMessageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CancelledMessageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Text(
            'Latest Order ID: ${viewModel.latestOrderId}',
           
          ),
        ),
      ),
    );
  }

  @override
  CancelledMessageViewModel viewModelBuilder(
    BuildContext context,
  ) => CancelledMessageViewModel();
}
