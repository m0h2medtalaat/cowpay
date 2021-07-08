import 'package:cowpay/helpers/screen_size.dart';
import 'package:flutter/material.dart';

class ButtonView extends StatelessWidget {
  final Color? backgroundColor, borderColor, textColor;
  final String? title;
  final void Function(BuildContext)? onClickFunction;
  final double? width;
  final double height;
  final BuildContext? mainContext;
  final double fontSize;

  const ButtonView(
      {/*Key key,*/
      required this.backgroundColor,
      this.borderColor,
      this.textColor,
      required this.title,
      this.onClickFunction,
      this.width,
      this.mainContext,
      this.height = 0.06,
      this.fontSize = 12.8})
      : super(/*key: key*/);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClickFunction!(mainContext!),
      child: Container(
          width: width ?? ScreenSize().width,
          height: ScreenSize().height! * height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor ?? backgroundColor!),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(title ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize * ScreenSize().height!,
                  color: textColor ?? Colors.white),
              textScaleFactor: 1)),
    );
  }
}
