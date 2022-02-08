import 'package:cowpay/helpers/screen_size.dart';
import 'package:flutter/material.dart';

class TextInputErrorView extends StatelessWidget {
  final String? errorMessage;

  const TextInputErrorView({/*Key key, */ this.errorMessage})
      : super(/*key: key*/);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0.007 * ScreenSize().height!),
        padding: EdgeInsets.symmetric(
            horizontal: (0.02 * ScreenSize().width!),
            vertical: 0.007 * ScreenSize().height!),
        width: ScreenSize().width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.red),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white)),
                margin: EdgeInsetsDirectional.only(
                    end: (0.02 * ScreenSize().width!)),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: (0.04 * ScreenSize().width!),
                )),
            FittedBox(fit: BoxFit.fitWidth, child: Text(errorMessage ?? "")),
          ],
        ));
  }
}
