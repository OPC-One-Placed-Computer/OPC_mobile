import 'package:flutter/material.dart';
import 'package:opc_mobile_development/ui/views/webview_screen/webview_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreenView extends StackedView<WebviewScreenViewModel> {
  final String url;

  const WebviewScreenView({Key? key, required this.url}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WebviewScreenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Payment'),
        automaticallyImplyLeading: false,
      ),
      body: WebViewWidget(
        controller: viewModel.controller,
      ),
    );
  }

  @override
  WebviewScreenViewModel viewModelBuilder(BuildContext context) =>
      WebviewScreenViewModel();

  @override
  void onViewModelReady(WebviewScreenViewModel viewModel) {
    viewModel.init(url);
    super.onViewModelReady(viewModel);
  }
}
