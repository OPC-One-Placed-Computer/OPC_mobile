import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.bottomsheets.dart';
import 'package:opc_mobile_development/app/app.dialogs.dart';
import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/ui/views/login/login_view.dart';
import 'package:opc_mobile_development/ui/views/product_details/productdetails_view.dart';
import 'package:opc_mobile_development/ui/views/products/products_view.dart';
import 'package:opc_mobile_development/ui/views/signup/signup_view.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ]
    );
  }
}
