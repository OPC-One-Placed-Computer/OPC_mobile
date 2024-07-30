// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i18;
import 'package:flutter/material.dart';
import 'package:opc_mobile_development/models/cart.dart' as _i20;
import 'package:opc_mobile_development/models/checkout.dart' as _i21;
import 'package:opc_mobile_development/models/product.dart' as _i19;
import 'package:opc_mobile_development/ui/views/add_to_cart/add_to_cart_view.dart'
    as _i10;
import 'package:opc_mobile_development/ui/views/cancelled_message/cancelled_message_view.dart'
    as _i17;
import 'package:opc_mobile_development/ui/views/checkout/checkout_view.dart'
    as _i11;
import 'package:opc_mobile_development/ui/views/detailed_product/detailed_product_view.dart'
    as _i16;
import 'package:opc_mobile_development/ui/views/home/home_view.dart' as _i5;
import 'package:opc_mobile_development/ui/views/login/login_view.dart' as _i3;
import 'package:opc_mobile_development/ui/views/order_placed/order_placed_view.dart'
    as _i12;
import 'package:opc_mobile_development/ui/views/place_order/place_order_view.dart'
    as _i9;
import 'package:opc_mobile_development/ui/views/product_details/product_details_view.dart'
    as _i8;
import 'package:opc_mobile_development/ui/views/profile/profile_view.dart'
    as _i7;
import 'package:opc_mobile_development/ui/views/signup/signup_view.dart' as _i4;
import 'package:opc_mobile_development/ui/views/startup/startup_view.dart'
    as _i2;
import 'package:opc_mobile_development/ui/views/store/store_view.dart' as _i6;
import 'package:opc_mobile_development/ui/views/success_message/success_message_view.dart'
    as _i15;
import 'package:opc_mobile_development/ui/views/view_order_placed/view_order_placed_view.dart'
    as _i13;
import 'package:opc_mobile_development/ui/views/webview_screen/webview_screen_view.dart'
    as _i14;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i22;

class Routes {
  static const startupView = '/startup-view';

  static const login = '/login-view';

  static const signup = '/signup-view';

  static const products = '/';

  static const homeView = '/home-view';

  static const storeView = '/store-view';

  static const profile = '/profile-view';

  static const products_view = '/productdetails-view';

  static const place_order = '/place-order-view';

  static const add_cart = '/add-to-cart-view';

  static const checkout = '/checkout-view';

  static const order_placed = '/order-placed-view';

  static const view_order_placed = '/view-order-placed-view';

  static const payment = '/webview-screen-view';

  static const success_message = '/success-message-view';

  static const detailed_product = '/detailed-product-view';

  static const cancelled_message = '/cancelled-message-view';

  static const all = <String>{
    startupView,
    login,
    signup,
    products,
    homeView,
    storeView,
    profile,
    products_view,
    place_order,
    add_cart,
    checkout,
    order_placed,
    view_order_placed,
    payment,
    success_message,
    detailed_product,
    cancelled_message,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.login,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.signup,
      page: _i4.SignupView,
    ),
    _i1.RouteDef(
      Routes.products,
      page: _i5.HomeView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i5.HomeView,
    ),
    _i1.RouteDef(
      Routes.storeView,
      page: _i6.StoreView,
    ),
    _i1.RouteDef(
      Routes.profile,
      page: _i7.ProfileView,
    ),
    _i1.RouteDef(
      Routes.products_view,
      page: _i8.ProductdetailsView,
    ),
    _i1.RouteDef(
      Routes.place_order,
      page: _i9.PlaceOrderView,
    ),
    _i1.RouteDef(
      Routes.add_cart,
      page: _i10.AddToCartView,
    ),
    _i1.RouteDef(
      Routes.checkout,
      page: _i11.CheckoutView,
    ),
    _i1.RouteDef(
      Routes.order_placed,
      page: _i12.OrderPlacedView,
    ),
    _i1.RouteDef(
      Routes.view_order_placed,
      page: _i13.ViewOrderPlacedView,
    ),
    _i1.RouteDef(
      Routes.payment,
      page: _i14.WebviewScreenView,
    ),
    _i1.RouteDef(
      Routes.success_message,
      page: _i15.SuccessMessageView,
    ),
    _i1.RouteDef(
      Routes.detailed_product,
      page: _i16.DetailedProductView,
    ),
    _i1.RouteDef(
      Routes.cancelled_message,
      page: _i17.CancelledMessageView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(key: args.key),
        settings: data,
      );
    },
    _i4.SignupView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SignupView(),
        settings: data,
      );
    },
    _i5.HomeView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.HomeView(),
        settings: data,
      );
    },
    _i6.StoreView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.StoreView(),
        settings: data,
      );
    },
    _i7.ProfileView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.ProfileView(),
        settings: data,
      );
    },
    _i8.ProductdetailsView: (data) {
      final args = data.getArgs<ProductdetailsViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.ProductdetailsView(key: args.key, product: args.product),
        settings: data,
      );
    },
    _i9.PlaceOrderView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.PlaceOrderView(),
        settings: data,
      );
    },
    _i10.AddToCartView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AddToCartView(),
        settings: data,
      );
    },
    _i11.CheckoutView: (data) {
      final args = data.getArgs<CheckoutViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.CheckoutView(
            key: args.key,
            selectedCartItems: args.selectedCartItems,
            onProductTapped: args.onProductTapped),
        settings: data,
      );
    },
    _i12.OrderPlacedView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.OrderPlacedView(),
        settings: data,
      );
    },
    _i13.ViewOrderPlacedView: (data) {
      final args = data.getArgs<ViewOrderPlacedViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.ViewOrderPlacedView(
            key: args.key,
            orderItems: args.orderItems,
            checkout: args.checkout,
            onProductTapped: args.onProductTapped),
        settings: data,
      );
    },
    _i14.WebviewScreenView: (data) {
      final args = data.getArgs<WebviewScreenViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.WebviewScreenView(key: args.key, url: args.url),
        settings: data,
      );
    },
    _i15.SuccessMessageView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.SuccessMessageView(),
        settings: data,
      );
    },
    _i16.DetailedProductView: (data) {
      final args = data.getArgs<DetailedProductViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.DetailedProductView(key: args.key, product: args.product),
        settings: data,
      );
    },
    _i17.CancelledMessageView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.CancelledMessageView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProductdetailsViewArguments {
  const ProductdetailsViewArguments({
    this.key,
    required this.product,
  });

  final _i18.Key? key;

  final _i19.Product product;

  @override
  String toString() {
    return '{"key": "$key", "product": "$product"}';
  }

  @override
  bool operator ==(covariant ProductdetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.product == product;
  }

  @override
  int get hashCode {
    return key.hashCode ^ product.hashCode;
  }
}

class CheckoutViewArguments {
  const CheckoutViewArguments({
    this.key,
    required this.selectedCartItems,
    required this.onProductTapped,
  });

  final _i18.Key? key;

  final List<_i20.Cart> selectedCartItems;

  final void Function(_i19.Product) onProductTapped;

  @override
  String toString() {
    return '{"key": "$key", "selectedCartItems": "$selectedCartItems", "onProductTapped": "$onProductTapped"}';
  }

  @override
  bool operator ==(covariant CheckoutViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.selectedCartItems == selectedCartItems &&
        other.onProductTapped == onProductTapped;
  }

  @override
  int get hashCode {
    return key.hashCode ^ selectedCartItems.hashCode ^ onProductTapped.hashCode;
  }
}

class ViewOrderPlacedViewArguments {
  const ViewOrderPlacedViewArguments({
    this.key,
    required this.orderItems,
    required this.checkout,
    required this.onProductTapped,
  });

  final _i18.Key? key;

  final List<_i21.OrderItem> orderItems;

  final _i21.Checkout checkout;

  final void Function(_i19.Product) onProductTapped;

  @override
  String toString() {
    return '{"key": "$key", "orderItems": "$orderItems", "checkout": "$checkout", "onProductTapped": "$onProductTapped"}';
  }

  @override
  bool operator ==(covariant ViewOrderPlacedViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.orderItems == orderItems &&
        other.checkout == checkout &&
        other.onProductTapped == onProductTapped;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        orderItems.hashCode ^
        checkout.hashCode ^
        onProductTapped.hashCode;
  }
}

class WebviewScreenViewArguments {
  const WebviewScreenViewArguments({
    this.key,
    required this.url,
  });

  final _i18.Key? key;

  final String url;

  @override
  String toString() {
    return '{"key": "$key", "url": "$url"}';
  }

  @override
  bool operator ==(covariant WebviewScreenViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.url == url;
  }

  @override
  int get hashCode {
    return key.hashCode ^ url.hashCode;
  }
}

class DetailedProductViewArguments {
  const DetailedProductViewArguments({
    this.key,
    required this.product,
  });

  final _i18.Key? key;

  final _i19.Product product;

  @override
  String toString() {
    return '{"key": "$key", "product": "$product"}';
  }

  @override
  bool operator ==(covariant DetailedProductViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.product == product;
  }

  @override
  int get hashCode {
    return key.hashCode ^ product.hashCode;
  }
}

extension NavigatorStateExtension on _i22.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLogin({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.login,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignup([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signup,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProducts([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.products,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStoreView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.storeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProducts_view({
    _i18.Key? key,
    required _i19.Product product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.products_view,
        arguments: ProductdetailsViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPlace_order([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.place_order,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAdd_cart([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.add_cart,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCheckout({
    _i18.Key? key,
    required List<_i20.Cart> selectedCartItems,
    required void Function(_i19.Product) onProductTapped,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.checkout,
        arguments: CheckoutViewArguments(
            key: key,
            selectedCartItems: selectedCartItems,
            onProductTapped: onProductTapped),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrder_placed([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.order_placed,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToView_order_placed({
    _i18.Key? key,
    required List<_i21.OrderItem> orderItems,
    required _i21.Checkout checkout,
    required void Function(_i19.Product) onProductTapped,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.view_order_placed,
        arguments: ViewOrderPlacedViewArguments(
            key: key,
            orderItems: orderItems,
            checkout: checkout,
            onProductTapped: onProductTapped),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPayment({
    _i18.Key? key,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.payment,
        arguments: WebviewScreenViewArguments(key: key, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSuccess_message([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.success_message,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDetailed_product({
    _i18.Key? key,
    required _i19.Product product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.detailed_product,
        arguments: DetailedProductViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCancelled_message([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cancelled_message,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLogin({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.login,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignup([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signup,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProducts([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.products,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStoreView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.storeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfile([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profile,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProducts_view({
    _i18.Key? key,
    required _i19.Product product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.products_view,
        arguments: ProductdetailsViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPlace_order([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.place_order,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAdd_cart([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.add_cart,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCheckout({
    _i18.Key? key,
    required List<_i20.Cart> selectedCartItems,
    required void Function(_i19.Product) onProductTapped,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.checkout,
        arguments: CheckoutViewArguments(
            key: key,
            selectedCartItems: selectedCartItems,
            onProductTapped: onProductTapped),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrder_placed([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.order_placed,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithView_order_placed({
    _i18.Key? key,
    required List<_i21.OrderItem> orderItems,
    required _i21.Checkout checkout,
    required void Function(_i19.Product) onProductTapped,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.view_order_placed,
        arguments: ViewOrderPlacedViewArguments(
            key: key,
            orderItems: orderItems,
            checkout: checkout,
            onProductTapped: onProductTapped),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPayment({
    _i18.Key? key,
    required String url,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.payment,
        arguments: WebviewScreenViewArguments(key: key, url: url),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSuccess_message([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.success_message,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDetailed_product({
    _i18.Key? key,
    required _i19.Product product,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.detailed_product,
        arguments: DetailedProductViewArguments(key: key, product: product),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCancelled_message([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.cancelled_message,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
