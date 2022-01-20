import 'dart:async';
import 'dart:io';

import 'package:cowpay/api_calls/exceptions.dart';
import 'package:cowpay/cowpay.dart';
import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/models/credit_card_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cowpay Credit Card unit test', () {
    test('cowpay fawry service create receipt (Success)', () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      CreditCardResponseModel creditCardResponseModel =
          await CowpayHelper.instance.creditCardCharge(
        expiryYear: "22",
        expiryMonth: "10",
        cvv: "123",
        cardNumber: "1234567891012369",
        description: 'description',
        amount: '32',
        customerMerchantProfileId: '2312',
        merchantReferenceId: "1515616515",
        customerEmail: 'sqeqedqqw@gmail.com',
        customerMobile: '01234567890',
        customerName: 'customerName',
      );
      expect(creditCardResponseModel, isA<CreditCardResponseModel>());
    });

    test('cowpay fawry service create receipt (Unauthorised exception)',
        () async {
      String token = "WrongToken";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          await CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(
              predicate((e) => e is UnauthorisedException && e.code == 401)));
    });

    test('cowpay fawry service create receipt expected (Socket exception)',
        () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(predicate((e) => e is SocketException)));
    });

    test('cowpay fawry service create receipt expected (TimeOut exception)',
        () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(predicate((e) => e is TimeoutException)));
    });

    test(
        'cowpay fawry service create receipt expected (InternalServerError exception)',
        () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(predicate((e) => e is InternalServerException)));
    });

    test(
        'cowpay fawry service create receipt expected (InvalidInput exception)',
        () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(predicate((e) => e is InternalServerException)));
    });
    test('cowpay fawry service create receipt expected (BadRequest exception)',
        () async {
      String token =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NasfasdasdiJ9.eyJhdWQiOiIxIiwianRpIjoiYjI3ZjQyNmU3MmE5NTdkN2Q2ZTU4YzU5NzgzMjZmNGZhOTQyZDMyZDRhYTI3OTcyNmY0ZmM3ZjJiN2ViNTE3ZGI4OWMyMjQwNzVmZmM1YTEiLCJpYXQiOiIxNjI1NDc2MDEzLjA4MTMzNSIsIm5iZiI6IjE2MjU0NzYwMTMuMDgxMzQxIiwiZXhwIjoiMTY1NzAxMjAxMy4wNzAyNDMiLCJzdWIiOiI2MTgiLCJzY29wZXMiOltdfQ.OeuZviB9L67k8WLKxWq2h-McrtglnVDP7xsuqIIvgxyA8WslrCDgYEOg5v2LPpiXbNB8p0oS-FyZdjAQf6mfDA";
      String merchantCode = "Chy9jpiJSONq";
      String merchantHash =
          "\$2y\$10\$2it43S96/fgf4VdiQKeQDeowX0T9RDmA3fRuZe8pRl8UmOYEAwz.6";
      CowpayHelper.instance.init(
        cowpayEnvironment: CowpayEnvironment.staging,
        token: token,
        merchantCode: merchantCode,
        merchantHash: merchantHash,
      );

      expect(
          CowpayHelper.instance.creditCardCharge(
            expiryYear: "22",
            expiryMonth: "10",
            cvv: "123",
            cardNumber: "1234567891012369",
            description: 'description',
            amount: '32',
            customerMerchantProfileId: '2312',
            merchantReferenceId: "1515616515",
            customerEmail: 'sqeqedqqw@gmail.com',
            customerMobile: '01234567890',
            customerName: 'customerName',
          ),
          throwsA(predicate((e) => e is BadRequestException)));
    });
  });
}
