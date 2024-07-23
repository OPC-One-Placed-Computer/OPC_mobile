import 'package:logger/logger.dart';
import 'package:opc_mobile_development/services/api/api_service_impl.dart';
import 'package:opc_mobile_development/services/api/auth/auth_api_service.dart';
import 'package:opc_mobile_development/services/api/auth/auth_service_impl.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service.dart';
import 'package:opc_mobile_development/services/api/shared_preference/shared_preference_service_impl.dart';
import 'package:opc_mobile_development/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:opc_mobile_development/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:opc_mobile_development/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:opc_mobile_development/ui/views/login/login_view.dart';
import 'package:opc_mobile_development/ui/views/signup/signup_view.dart';
import 'package:opc_mobile_development/ui/views/home/home_view.dart';
import 'package:opc_mobile_development/ui/views/store/store_view.dart';

import 'package:opc_mobile_development/ui/views/profile/profile_view.dart';
import 'package:opc_mobile_development/ui/views/product_details/product_details_view.dart';
import 'package:opc_mobile_development/services/api/api_service_service.dart';
import 'package:opc_mobile_development/ui/views/place_order/place_order_view.dart';
import 'package:opc_mobile_development/ui/views/add_to_cart/add_to_cart_view.dart';
import 'package:opc_mobile_development/ui/views/checkout/checkout_view.dart';

import 'package:opc_mobile_development/ui/views/order_placed/order_placed_view.dart';
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart';
import 'package:opc_mobile_development/ui/views/webview_screen/webview_screen_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView, name: 'login'),
    MaterialRoute(page: SignupView, name: 'signup'),
    MaterialRoute(page: HomeView, name: 'products', initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StoreView),

    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ProductdetailsView, name: 'products_view'),
    MaterialRoute(page: PlaceOrderView, name: 'place_order'),
    MaterialRoute(page: AddToCartView, name: 'add_cart'),
    MaterialRoute(page: CheckoutView, name: 'checkout'),

    MaterialRoute(page: OrderPlacedView, name: 'order_placed'),
    MaterialRoute(page: ViewOrderPlacedView, name: 'view_order_placed'),
    MaterialRoute(page: WebviewScreenView, name: 'payment'),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ApiServiceImpl, asType: ApiServiceService),
    LazySingleton(classType: AuthServiceImpl, asType: AuthApiService),
    LazySingleton(
        classType: SharedPreferenceServiceImpl,
        asType: SharedPreferenceService),
    LazySingleton(classType: SnackbarService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

var logger = Logger(printer: PrettyPrinter(), level: Level.debug);
