import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.bottomsheets.dart';
import 'package:opc_mobile_development/app/app.dialogs.dart';
import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/ui/views/login/login_view.dart';
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
      initialRoute: Routes.productsView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      routes: {
        '/login': (context) => const LoginView(), // Add the login route
        '/register': (context) => const SignupView(), // Add the register route
      },
    );
  }
}
