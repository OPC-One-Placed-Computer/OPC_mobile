import 'package:opc_mobile_development/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:opc_mobile_development/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:opc_mobile_development/ui/views/home/home_view.dart';
import 'package:opc_mobile_development/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:opc_mobile_development/ui/views/login/login_view.dart';
import 'package:opc_mobile_development/ui/views/signup/signup_view.dart';
import 'package:opc_mobile_development/ui/views/products/products_view.dart';
import 'package:opc_mobile_development/ui/views/store/store_view.dart';
import 'package:opc_mobile_development/ui/views/wishlist/wishlist_view.dart';
import 'package:opc_mobile_development/ui/views/profile/profile_view.dart';
import 'package:opc_mobile_development/ui/views/product_details/productdetails_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupView, name: 'signup'),
    MaterialRoute(page: ProductsView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StoreView),
    MaterialRoute(page: WishlistView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ProductdetailsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
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
