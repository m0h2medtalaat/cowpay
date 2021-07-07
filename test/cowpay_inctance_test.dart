import 'package:cowpay/cowpay.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cowpay Cash collection unit test', () {
    test('CowPay.init() test Package initialization', () {
      Cowpay cowpay = Cowpay();

      cowpay.init(
          cowpayEnvironment: CowpayEnvironment.staging,
          token: "ASDISDIOAD",
          merchantCode: "merchantCode",
          merchantHash: "merchantHash");

      expect(cowpay, Cowpay.instance);
    });
  });
}
