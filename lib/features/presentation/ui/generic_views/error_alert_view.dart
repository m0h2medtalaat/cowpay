import 'package:cowpay/core/helpers/enum_models.dart';
import 'package:flutter/material.dart';

import 'dialog_view.dart';

class ErrorAlertView {
  final BuildContext context;
  final String content;

  ErrorAlertView({required this.context, required this.content});

  Future<void> ackAlert() {
    debugPrint('Error Message:  $content');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogView(
            dialogType: DialogType.DIALOG_ERROR,
            content: content,
            mainContext: context,
          );
        });
  }
}
