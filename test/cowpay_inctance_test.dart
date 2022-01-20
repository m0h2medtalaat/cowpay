import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cowpay Cash collection unit test', () {
    test('CowPay.init() test Package initialization', () {
      CowpayHelper cowpay = CowpayHelper();

      cowpay.init(
          cowpayEnvironment: CowpayEnvironment.staging,
          token: "ASDISDIOAD",
          merchantCode: "merchantCode",
          merchantHash: "merchantHash");

      expect(cowpay, CowpayHelper.instance);
    });
  });
}
