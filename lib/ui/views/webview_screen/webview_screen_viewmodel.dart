import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreenViewModel extends AppBaseViewModel {
  late WebViewController controller;

  void init(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          logger.i('Page finished loading: $url');
          if (url.contains('cancel')) {
            logger.i('Detected cancel session. Navigating back.');
            final orderId = url.replaceAll('https://order.cancel/', '');
            logger.i('ORDER_ID: $orderId');
            Future.delayed(const Duration(seconds: 4), () {
              navigationService.back();
            });
          }
          if (url.contains('success')) {
            logger.i('Detected success session. Navigating to order_placed.');
            Future.delayed(const Duration(seconds: 4), () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigationService.navigateTo(Routes.homeView);
              });
            });
          }
        },
      ))
      ..loadRequest(Uri.parse(url));
  }
}
