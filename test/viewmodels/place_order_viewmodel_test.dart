import 'package:flutter_test/flutter_test.dart';
import 'package:opc_mobile_development/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('PlaceOrderViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
