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
    final snackbarService = locator<SnackbarService>();

    snackbarService.registerSnackbarConfig(
      SnackbarConfig(
        backgroundColor: Color.fromARGB(255, 114, 114, 114),
        borderRadius: 16,
        duration: Constants.defDuration,
        snackPosition: SnackPosition.BOTTOM,
        textColor: Color.fromARGB(255, 18, 18, 18),
        margin: const EdgeInsets.all(10),
        dismissDirection: DismissDirection.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 10, 0, 16),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
