import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/ui/generic_views/text_input_error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputView extends StatelessWidget {
  final void Function(BuildContext, String)? onChange;
  final void Function(
    BuildContext,
  )? onHelpChange;
  final BuildContext? mainContext;
  final bool? obscureText, isNotValid, showHelp, showHelpIcon, enabled;
  final int maxLength;
  final String? image, hintText, errorMessage, helpText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(BuildContext)? onFieldSubmitted;
  final double? width;
  final InputDecoration? inputDecoration;
  final TextStyle? style;
  final Color? mainColor;

  const TextInputView(
      {/*Key key,*/
      this.onChange,
      this.onFieldSubmitted,
      this.onHelpChange,
      this.mainContext,
      this.obscureText = false,
      this.image,
      this.hintText,
      this.isNotValid,
      this.textInputType,
      this.mainColor,
      this.textInputAction,
      this.errorMessage,
      this.currentFocus,
      this.showHelp,
      this.nextFocus,
      this.helpText,
      this.enabled = true,
      this.maxLength = 50,
      this.initialValue,
      this.showHelpIcon = false,
      this.suffixIcon,
      this.controller,
      this.style,
      this.inputDecoration,
      this.width})
      : super(/*key: key*/);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTextFormField(context),
        if (errorMessage != null && isNotValid!)
          TextInputErrorView(
            errorMessage: errorMessage,
          ),
      ],
    );
  }

  Container buildHelpText() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: (0.007 * ScreenSize().height!)),
      padding: EdgeInsets.symmetric(
          horizontal: (0.02 * ScreenSize().width!),
          vertical: (0.007 * ScreenSize().height!)),
      width: width ?? ScreenSize().width!,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: Colors.black),
      child: Text(
        helpText!,
        style: TextStyle(height: 1.3),
      ),
    );
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue ?? null,
      onChanged: (value) => onChange!(mainContext!, value),
      maxLength: maxLength,
      maxLengthEnforced: true,
      controller: controller,
      enabled: enabled,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      obscureText: obscureText!,
      focusNode: currentFocus,
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(nextFocus);
        } else {
          onFieldSubmitted!(mainContext!);
        }
      },
      style: style ?? TextStyle(color: mainColor ?? Colors.black, fontSize: 14),
      decoration: inputDecoration ??
          InputDecoration(
            contentPadding: inputDecoration?.contentPadding ??
                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            counterText: '',
            prefixIcon: image != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.1 * ScreenSize().width!,
                        height: 0.1 * ScreenSize().width!,
                        child: Image(
                          image: AssetImage('resources/images/$image.png'),
                          color: enabled!
                              ? isNotValid!
                                  ? Colors.red
                                  : Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  )
                : null,
            // suffixIcon: showHelpIcon!
            //     ? InkWell(
            //         onTap: () => onHelpChange!(mainContext!),
            //         child: Container(
            //           width: 15.ssp,
            //           height: 15.ssp,
            //           padding: EdgeInsets.all(10.ssp),
            //           child: Image.asset(
            //             'resources/images/information.png',
            //             height: 0.0.sh,
            //           ),
            //         ),
            //       )
            //     : suffixIcon == null
            //         ? SizedBox()
            //         : suffixIcon,
            hintText: hintText!,
            labelText: hintText!,
            isDense: inputDecoration?.isDense ?? false,
            hintStyle: inputDecoration?.hintStyle ??
                TextStyle(
                    color: mainColor?.withOpacity(0.4) ?? Color(0x9066496A),
                    fontSize: 14),
            labelStyle: inputDecoration?.labelStyle ??
                TextStyle(
                    color: mainColor?.withOpacity(0.4) ?? Color(0x9066496A),
                    fontSize: 14),
            focusedBorder: inputDecoration?.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                      color: mainColor ?? Color(0xff66496A), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            enabledBorder: inputDecoration?.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: mainColor?.withOpacity(0.5) ?? Color(0x3066496A),
                      width: 1.0),
                ),
            disabledBorder: inputDecoration?.disabledBorder ?? buildBorder(),
          ),
      keyboardType: textInputType,
      textInputAction: textInputAction,
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: isNotValid! ? Colors.red : Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }
}
