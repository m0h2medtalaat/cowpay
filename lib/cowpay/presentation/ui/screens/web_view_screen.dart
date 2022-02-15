library cowpay;

import 'dart:async';
import 'dart:io';

import 'package:cowpay/core/helpers/cowpay_helper.dart';
import 'package:cowpay/core/helpers/localization.dart';
import 'package:cowpay/cowpay/domain/entities/credit_card_entity.dart';
import 'package:cowpay/cowpay/presentation/ui/generic_views/dialog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

export 'package:cowpay/core/helpers/enum_models.dart';

class WebViewScreen extends StatefulWidget {
  final CreditCardEntity creditCardEntity;

  WebViewScreen({required this.creditCardEntity});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Localization().localizationCode == LocalizationCode.ar
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // title: Text(Localization().localizationMap["paymentMethod"]),
          backgroundColor: Color(0xff3D1A54),
        ),
        body: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl:
                    '${CowpayHelper.activeEnvironment!.baseUrl}/v2/card/form/${widget.creditCardEntity.cowpayReferenceId}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains('URL2')) {
                    _successDialog(context);
                    return NavigationDecision.prevent;
                  } else if (request.url.contains('URL3')) {
                    _errorDialog(context);
                    return NavigationDecision.prevent;
                  } else
                    return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              ),
            )
          ],
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Future<void> _successDialog(
    BuildContext _context,
  ) {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogView(
            dialogType: DialogType.DIALOG_INFO,
            actionText: "done",
            content: "Your Payment successfully Done",
            onCLick: (_) {
              //TODO: do onSuccess
              Navigator.of(context).pop();
            },
            mainContext: _context,
            // title: 'Success',
          );
        });
  }

  Future<void> _errorDialog(
    BuildContext _context,
  ) {
    return showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogView(
            // title: "Error",
            dialogType: DialogType.DIALOG_ERROR,
            actionText: "done",
            content: "Something went wrong  please try again later",
            onCLick: (_) {
              //TODO: do onError
              Navigator.of(context).pop();
            },
            mainContext: _context,
          );
        });
  }
}
