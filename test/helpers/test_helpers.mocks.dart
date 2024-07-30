// Mocks generated by Mockito 5.4.4 from annotations
// in opc_mobile_development/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:typed_data' as _i13;
import 'dart:ui' as _i11;

import 'package:flutter/material.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:opc_mobile_development/models/cart.dart' as _i3;
import 'package:opc_mobile_development/models/checkout.dart' as _i5;
import 'package:opc_mobile_development/models/current_authentication.dart'
    as _i4;
import 'package:opc_mobile_development/models/product.dart' as _i2;
import 'package:opc_mobile_development/models/update_user.dart' as _i6;
import 'package:opc_mobile_development/services/api/api_service_service.dart'
    as _i12;
import 'package:stacked_services/stacked_services.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePaginatedProducts_0 extends _i1.SmartFake
    implements _i2.PaginatedProducts {
  _FakePaginatedProducts_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProduct_1 extends _i1.SmartFake implements _i2.Product {
  _FakeProduct_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCart_2 extends _i1.SmartFake implements _i3.Cart {
  _FakeCart_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCurrentAuthentication_3 extends _i1.SmartFake
    implements _i4.CurrentAuthentication {
  _FakeCurrentAuthentication_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCheckout_4 extends _i1.SmartFake implements _i5.Checkout {
  _FakeCheckout_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUpdateUser_5 extends _i1.SmartFake implements _i6.UpdateUser {
  _FakeUpdateUser_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUpdatePassword_6 extends _i1.SmartFake
    implements _i6.UpdatePassword {
  _FakeUpdatePassword_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i7.NavigationService {
  @override
  String get previousRoute => (super.noSuchMethod(
        Invocation.getter(#previousRoute),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#previousRoute),
        ),
        returnValueForMissingStub: _i8.dummyValue<String>(
          this,
          Invocation.getter(#previousRoute),
        ),
      ) as String);

  @override
  String get currentRoute => (super.noSuchMethod(
        Invocation.getter(#currentRoute),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#currentRoute),
        ),
        returnValueForMissingStub: _i8.dummyValue<String>(
          this,
          Invocation.getter(#currentRoute),
        ),
      ) as String);

  @override
  _i9.GlobalKey<_i9.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(
        Invocation.method(
          #nestedNavigationKey,
          [index],
        ),
        returnValueForMissingStub: null,
      ) as _i9.GlobalKey<_i9.NavigatorState>?);

  @override
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    _i7.Transition? defaultTransitionStyle,
    String? defaultTransition,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #config,
          [],
          {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransitionStyle: defaultTransitionStyle,
            #defaultTransition: defaultTransition,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<T?>? navigateWithTransition<T>(
    _i9.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i9.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i7.Transition? transitionClass,
    _i7.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? replaceWithTransition<T>(
    _i9.Widget? page, {
    bool? opaque,
    String? transition = r'',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i9.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i7.Transition? transitionClass,
    _i7.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWithTransition,
          [page],
          {
            #opaque: opaque,
            #transition: transition,
            #duration: duration,
            #popGesture: popGesture,
            #id: id,
            #curve: curve,
            #fullscreenDialog: fullscreenDialog,
            #preventDuplicates: preventDuplicates,
            #transitionClass: transitionClass,
            #transitionStyle: transitionStyle,
            #routeName: routeName,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  bool back<T>({
    dynamic result,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #back,
          [],
          {
            #result: result,
            #id: id,
          },
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void popUntil(
    _i9.RoutePredicate? predicate, {
    int? id,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #popUntil,
          [predicate],
          {#id: id},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void popRepeated(int? popTimes) => super.noSuchMethod(
        Invocation.method(
          #popRepeated,
          [popTimes],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<T?>? navigateTo<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i9.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateTo,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? navigateToView<T>(
    _i9.Widget? view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    _i9.Curve? curve,
    Duration? duration,
    bool? fullscreenDialog = false,
    bool? popGesture,
    bool? preventDuplicates = true,
    _i7.Transition? transition,
    _i7.Transition? transitionStyle,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #navigateToView,
          [view],
          {
            #arguments: arguments,
            #id: id,
            #opaque: opaque,
            #curve: curve,
            #duration: duration,
            #fullscreenDialog: fullscreenDialog,
            #popGesture: popGesture,
            #preventDuplicates: preventDuplicates,
            #transition: transition,
            #transitionStyle: transitionStyle,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? replaceWith<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i9.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #replaceWith,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
            #transition: transition,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? clearStackAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? clearStackAndShowView<T>(
    _i9.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearStackAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? clearTillFirstAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShow,
          [routeName],
          {
            #arguments: arguments,
            #id: id,
            #preventDuplicates: preventDuplicates,
            #parameters: parameters,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? clearTillFirstAndShowView<T>(
    _i9.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #clearTillFirstAndShowView,
          [view],
          {
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);

  @override
  _i10.Future<T?>? pushNamedAndRemoveUntil<T>(
    String? routeName, {
    _i9.RoutePredicate? predicate,
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNamedAndRemoveUntil,
          [routeName],
          {
            #predicate: predicate,
            #arguments: arguments,
            #id: id,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i10.Future<T?>?);
}

/// A class which mocks [BottomSheetService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBottomSheetService extends _i1.Mock
    implements _i7.BottomSheetService {
  @override
  void setCustomSheetBuilders(Map<dynamic, _i7.SheetBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #setCustomSheetBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<_i7.SheetResponse<dynamic>?> showBottomSheet({
    required String? title,
    String? description,
    String? confirmButtonTitle = r'Ok',
    String? cancelButtonTitle,
    bool? enableDrag = true,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
    double? elevation = 1.0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showBottomSheet,
          [],
          {
            #title: title,
            #description: description,
            #confirmButtonTitle: confirmButtonTitle,
            #cancelButtonTitle: cancelButtonTitle,
            #enableDrag: enableDrag,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
            #elevation: elevation,
          },
        ),
        returnValue: _i10.Future<_i7.SheetResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i10.Future<_i7.SheetResponse<dynamic>?>.value(),
      ) as _i10.Future<_i7.SheetResponse<dynamic>?>);

  @override
  _i10.Future<_i7.SheetResponse<T>?> showCustomSheet<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i11.Color? barrierColor = const _i11.Color(2315255808),
    double? elevation = 1.0,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    String? barrierLabel = r'',
    dynamic customData,
    R? data,
    bool? enableDrag = true,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomSheet,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #elevation: elevation,
            #barrierDismissible: barrierDismissible,
            #isScrollControlled: isScrollControlled,
            #barrierLabel: barrierLabel,
            #customData: customData,
            #data: data,
            #enableDrag: enableDrag,
            #exitBottomSheetDuration: exitBottomSheetDuration,
            #enterBottomSheetDuration: enterBottomSheetDuration,
            #ignoreSafeArea: ignoreSafeArea,
            #useRootNavigator: useRootNavigator,
          },
        ),
        returnValue: _i10.Future<_i7.SheetResponse<T>?>.value(),
        returnValueForMissingStub: _i10.Future<_i7.SheetResponse<T>?>.value(),
      ) as _i10.Future<_i7.SheetResponse<T>?>);

  @override
  void completeSheet(_i7.SheetResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeSheet,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DialogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDialogService extends _i1.Mock implements _i7.DialogService {
  @override
  void registerCustomDialogBuilders(
          Map<dynamic, _i7.DialogBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilders,
          [builders],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void registerCustomDialogBuilder({
    required dynamic variant,
    required _i9.Widget Function(
      _i9.BuildContext,
      _i7.DialogRequest<dynamic>,
      dynamic Function(_i7.DialogResponse<dynamic>),
    )? builder,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #registerCustomDialogBuilder,
          [],
          {
            #variant: variant,
            #builder: builder,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<_i7.DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    _i11.Color? cancelTitleColor,
    String? buttonTitle = r'Ok',
    _i11.Color? buttonTitleColor,
    bool? barrierDismissible = false,
    _i7.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #buttonTitle: buttonTitle,
            #buttonTitleColor: buttonTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i10.Future<_i7.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i10.Future<_i7.DialogResponse<dynamic>?>.value(),
      ) as _i10.Future<_i7.DialogResponse<dynamic>?>);

  @override
  _i10.Future<_i7.DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i11.Color? barrierColor = const _i11.Color(2315255808),
    bool? barrierDismissible = false,
    String? barrierLabel = r'',
    bool? useSafeArea = true,
    dynamic customData,
    R? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showCustomDialog,
          [],
          {
            #variant: variant,
            #title: title,
            #description: description,
            #hasImage: hasImage,
            #imageUrl: imageUrl,
            #showIconInMainButton: showIconInMainButton,
            #mainButtonTitle: mainButtonTitle,
            #showIconInSecondaryButton: showIconInSecondaryButton,
            #secondaryButtonTitle: secondaryButtonTitle,
            #showIconInAdditionalButton: showIconInAdditionalButton,
            #additionalButtonTitle: additionalButtonTitle,
            #takesInput: takesInput,
            #barrierColor: barrierColor,
            #barrierDismissible: barrierDismissible,
            #barrierLabel: barrierLabel,
            #useSafeArea: useSafeArea,
            #customData: customData,
            #data: data,
          },
        ),
        returnValue: _i10.Future<_i7.DialogResponse<T>?>.value(),
        returnValueForMissingStub: _i10.Future<_i7.DialogResponse<T>?>.value(),
      ) as _i10.Future<_i7.DialogResponse<T>?>);

  @override
  _i10.Future<_i7.DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String? cancelTitle = r'Cancel',
    _i11.Color? cancelTitleColor,
    String? confirmationTitle = r'Ok',
    _i11.Color? confirmationTitleColor,
    bool? barrierDismissible = false,
    _i7.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #showConfirmationDialog,
          [],
          {
            #title: title,
            #description: description,
            #cancelTitle: cancelTitle,
            #cancelTitleColor: cancelTitleColor,
            #confirmationTitle: confirmationTitle,
            #confirmationTitleColor: confirmationTitleColor,
            #barrierDismissible: barrierDismissible,
            #dialogPlatform: dialogPlatform,
          },
        ),
        returnValue: _i10.Future<_i7.DialogResponse<dynamic>?>.value(),
        returnValueForMissingStub:
            _i10.Future<_i7.DialogResponse<dynamic>?>.value(),
      ) as _i10.Future<_i7.DialogResponse<dynamic>?>);

  @override
  void completeDialog(_i7.DialogResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(
          #completeDialog,
          [response],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [ApiServiceService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiServiceService extends _i1.Mock implements _i12.ApiServiceService {
  @override
  _i10.Future<_i2.PaginatedProducts> getProducts({int? page = 1}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProducts,
          [],
          {#page: page},
        ),
        returnValue:
            _i10.Future<_i2.PaginatedProducts>.value(_FakePaginatedProducts_0(
          this,
          Invocation.method(
            #getProducts,
            [],
            {#page: page},
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<_i2.PaginatedProducts>.value(_FakePaginatedProducts_0(
          this,
          Invocation.method(
            #getProducts,
            [],
            {#page: page},
          ),
        )),
      ) as _i10.Future<_i2.PaginatedProducts>);

  @override
  _i10.Future<_i2.Product> getProduct(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getProduct,
          [id],
        ),
        returnValue: _i10.Future<_i2.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #getProduct,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<_i2.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #getProduct,
            [id],
          ),
        )),
      ) as _i10.Future<_i2.Product>);

  @override
  _i10.Future<_i3.Cart> addToCart(
    int? productId,
    int? quantity,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToCart,
          [
            productId,
            quantity,
          ],
        ),
        returnValue: _i10.Future<_i3.Cart>.value(_FakeCart_2(
          this,
          Invocation.method(
            #addToCart,
            [
              productId,
              quantity,
            ],
          ),
        )),
        returnValueForMissingStub: _i10.Future<_i3.Cart>.value(_FakeCart_2(
          this,
          Invocation.method(
            #addToCart,
            [
              productId,
              quantity,
            ],
          ),
        )),
      ) as _i10.Future<_i3.Cart>);

  @override
  _i10.Future<List<_i3.Cart>> getAllCartItems() => (super.noSuchMethod(
        Invocation.method(
          #getAllCartItems,
          [],
        ),
        returnValue: _i10.Future<List<_i3.Cart>>.value(<_i3.Cart>[]),
        returnValueForMissingStub:
            _i10.Future<List<_i3.Cart>>.value(<_i3.Cart>[]),
      ) as _i10.Future<List<_i3.Cart>>);

  @override
  _i10.Future<void> deleteFromCart(int? cartId) => (super.noSuchMethod(
        Invocation.method(
          #deleteFromCart,
          [cartId],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<_i4.CurrentAuthentication> getCurrentAuthentication() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentAuthentication,
          [],
        ),
        returnValue: _i10.Future<_i4.CurrentAuthentication>.value(
            _FakeCurrentAuthentication_3(
          this,
          Invocation.method(
            #getCurrentAuthentication,
            [],
          ),
        )),
        returnValueForMissingStub: _i10.Future<_i4.CurrentAuthentication>.value(
            _FakeCurrentAuthentication_3(
          this,
          Invocation.method(
            #getCurrentAuthentication,
            [],
          ),
        )),
      ) as _i10.Future<_i4.CurrentAuthentication>);

  @override
  _i10.Future<_i5.Checkout> checkOut(
    String? fullName,
    String? address,
    String? selectedPaymentMethod,
    int? total,
    List<String>? cartItems,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkOut,
          [
            fullName,
            address,
            selectedPaymentMethod,
            total,
            cartItems,
          ],
        ),
        returnValue: _i10.Future<_i5.Checkout>.value(_FakeCheckout_4(
          this,
          Invocation.method(
            #checkOut,
            [
              fullName,
              address,
              selectedPaymentMethod,
              total,
              cartItems,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<_i5.Checkout>.value(_FakeCheckout_4(
          this,
          Invocation.method(
            #checkOut,
            [
              fullName,
              address,
              selectedPaymentMethod,
              total,
              cartItems,
            ],
          ),
        )),
      ) as _i10.Future<_i5.Checkout>);

  @override
  _i10.Future<Map<String, dynamic>> getOrdersDetails({
    int? page = 1,
    int? pageSize = 10,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrdersDetails,
          [],
          {
            #page: page,
            #pageSize: pageSize,
          },
        ),
        returnValue:
            _i10.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
        returnValueForMissingStub:
            _i10.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i10.Future<Map<String, dynamic>>);

  @override
  _i10.Future<_i6.UpdateUser> updateUser(
    _i6.UpdateUser? user,
    _i13.Uint8List? imageBytes,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            user,
            imageBytes,
          ],
        ),
        returnValue: _i10.Future<_i6.UpdateUser>.value(_FakeUpdateUser_5(
          this,
          Invocation.method(
            #updateUser,
            [
              user,
              imageBytes,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<_i6.UpdateUser>.value(_FakeUpdateUser_5(
          this,
          Invocation.method(
            #updateUser,
            [
              user,
              imageBytes,
            ],
          ),
        )),
      ) as _i10.Future<_i6.UpdateUser>);

  @override
  _i10.Future<_i6.UpdatePassword> updatePassword(_i6.UpdatePassword? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePassword,
          [user],
        ),
        returnValue:
            _i10.Future<_i6.UpdatePassword>.value(_FakeUpdatePassword_6(
          this,
          Invocation.method(
            #updatePassword,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<_i6.UpdatePassword>.value(_FakeUpdatePassword_6(
          this,
          Invocation.method(
            #updatePassword,
            [user],
          ),
        )),
      ) as _i10.Future<_i6.UpdatePassword>);

  @override
  _i10.Future<_i13.Uint8List> retrieveProfileImage(String? filename) =>
      (super.noSuchMethod(
        Invocation.method(
          #retrieveProfileImage,
          [filename],
        ),
        returnValue: _i10.Future<_i13.Uint8List>.value(_i13.Uint8List(0)),
        returnValueForMissingStub:
            _i10.Future<_i13.Uint8List>.value(_i13.Uint8List(0)),
      ) as _i10.Future<_i13.Uint8List>);

  @override
  _i10.Future<_i13.Uint8List> retrieveProductImage(String? path) =>
      (super.noSuchMethod(
        Invocation.method(
          #retrieveProductImage,
          [path],
        ),
        returnValue: _i10.Future<_i13.Uint8List>.value(_i13.Uint8List(0)),
        returnValueForMissingStub:
            _i10.Future<_i13.Uint8List>.value(_i13.Uint8List(0)),
      ) as _i10.Future<_i13.Uint8List>);

  @override
  _i10.Future<void> canceledOrder(int? orderId) => (super.noSuchMethod(
        Invocation.method(
          #canceledOrder,
          [orderId],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<String> getPaymentLink(
    String? fullName,
    String? address,
    String? selectedPaymentMethod,
    int? total,
    List<String>? cartItems,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPaymentLink,
          [
            fullName,
            address,
            selectedPaymentMethod,
            total,
            cartItems,
          ],
        ),
        returnValue: _i10.Future<String>.value(_i8.dummyValue<String>(
          this,
          Invocation.method(
            #getPaymentLink,
            [
              fullName,
              address,
              selectedPaymentMethod,
              total,
              cartItems,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i10.Future<String>.value(_i8.dummyValue<String>(
          this,
          Invocation.method(
            #getPaymentLink,
            [
              fullName,
              address,
              selectedPaymentMethod,
              total,
              cartItems,
            ],
          ),
        )),
      ) as _i10.Future<String>);

  @override
  _i10.Future<void> updateQuantity(
    int? productId,
    int? quantity,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateQuantity,
          [
            productId,
            quantity,
          ],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
}
