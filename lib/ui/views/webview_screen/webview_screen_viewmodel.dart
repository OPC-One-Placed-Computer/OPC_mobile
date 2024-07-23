import 'package:opc_mobile_development/app/app.dart';
import 'package:opc_mobile_development/app/app_base_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreenViewModel extends AppBaseViewModel {
  final controller = WebViewController();

  init(String url) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onUrlChange: (url) {
        logger.i(url.url);
        final link = url.url ?? '';
        if (link.contains('cancel?session')) {
          navigationService.back();
        }
        if (link.contains('success?session')) {
          //route orders
        }
      }))
      ..loadRequest(Uri.parse(url));
  }
}
