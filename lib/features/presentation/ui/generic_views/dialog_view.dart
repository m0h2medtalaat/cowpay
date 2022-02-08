import 'package:cowpay/core/helpers/enum_models.dart';
import 'package:cowpay/core/helpers/screen_size.dart';
import 'package:flutter/material.dart';

class DialogView extends StatelessWidget {
  final String content;
  final String? actionText;
  final String? cancelText;
  final void Function(BuildContext)? onCLick, extraOnCancel;
  final BuildContext mainContext;
  final DialogType dialogType;
  final String? image;
  final String? title;
  const DialogView(
      {Key? key,
      required this.content,
      this.actionText,
      this.image,
      this.onCLick,
      required this.mainContext,
      required this.dialogType,
      this.extraOnCancel,
      this.title,
      this.cancelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: Colors.transparent,
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenSize().height ?? 0 * 0.04),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Container(
                  height: ScreenSize().height ?? 0 * 0.1,
                  width: ScreenSize().height ?? 0 * 0.1,
                  child: Image.asset("resources/images/$image.png"))
              : dialogType.image != null
                  ? Container(
                      height: ScreenSize().height ?? 0 * 0.1,
                      width: ScreenSize().height ?? 0 * 0.1,
                      child: dialogType.image)
                  : SizedBox(),
          SizedBox(
            height: ScreenSize().height ?? 0 * 0.015,
          ),
          Text(
            title ?? 'Title',
            textAlign: dialogType == DialogType.DIALOG_WARNING
                ? TextAlign.start
                : TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                height: 1.4,
                fontWeight: FontWeight.bold,
                fontSize: 19),
            textScaleFactor: 0.8,
          ),
          SizedBox(
            height: ScreenSize().height ?? 0 * 0.015,
          ),
          Text(
            content,
            textAlign: dialogType == DialogType.DIALOG_WARNING
                ? TextAlign.start
                : TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              height: 1.2,
            ),
            textScaleFactor: 0.8,
          ),
          SizedBox(
            height: ScreenSize().height ?? 0 * 0.015,
          ),
          if (actionText != null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: cancelText != null
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.center,
                  children: [
                    if (cancelText != null) buildInkWellCancel(context),
                    SizedBox(
                      width: 10,
                    ),
                    if (actionText != null) buildInkWellActionClick(context),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  InkWell buildInkWellActionClick(BuildContext context) {
    return InkWell(
      onTap: () => callCallaBack(context),
      child: Container(
        width: cancelText != null ? null : ScreenSize().width ?? 0 * 0.6,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: dialogType.color, width: 1.5)),
        child: Text(
          actionText!,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: dialogType.color),
          textScaleFactor: 0.7,
        ),
      ),
    );
  }

  InkWell buildInkWellCancel(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          'cancel',
          style: TextStyle(color: dialogType.color),
          textScaleFactor: 0.7,
        ),
      ),
    );
  }

  void callCallaBack(BuildContext context) {
    Navigator.pop(context);
    onCLick!(mainContext);
  }

  void cancelClick(BuildContext context) {
    Navigator.pop(context);
    onCLick!(mainContext);
  }

  static Future<void> dialog(
    BuildContext _context,
    String content,
    String title,
    DialogType dialogType, {
    String? actionText,
    String cancelText = 'cancel',
    void Function(BuildContext)? onCLick,
    bool barrierDismissible = true,
    void Function(BuildContext)? extraOnCancel,
  }) {
    debugPrint('Error Message:  $content');
    return showDialog(
        barrierDismissible: barrierDismissible,
        context: _context,
        builder: (BuildContext context) {
          return DialogView(
            dialogType: dialogType,
            content: content,
            title: title,
            mainContext: _context,
            actionText: actionText!,
            extraOnCancel: extraOnCancel,
            onCLick: onCLick,
            cancelText: cancelText,
          );
        });
  }
}
