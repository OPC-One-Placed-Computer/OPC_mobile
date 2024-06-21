import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.bottomsheets.dart';
import 'package:opc_mobile_development/app/app.dialogs.dart';
import 'package:opc_mobile_development/app/app.locator.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:opc_mobile_development/utils/constants.dart';
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
    locator<SnackbarService>().registerSnackbarConfig(
      SnackbarConfig(
        duration: Constants.defDuration,
        borderRadius: 16
      )
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ]);
  }
}
