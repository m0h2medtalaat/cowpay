import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/ui/generic_views/text_input_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownView extends StatelessWidget {
  final bool isNotValid;
  final Color? mainColor;
  final List<String> list;
  final Function(BuildContext, String?) onChange;
  final String? value;
  final String? icon;
  final String hintText;

  const DropDownView(
      {Key? key,
      this.value,
      required this.hintText,
      required this.isNotValid,
      required this.onChange,
      required this.list,
      this.mainColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: isNotValid ? Colors.red : mainColor ?? Color(0xff66496A),
                width: 1,
              ),
              color: Colors.white),
          child: Row(
            children: [
              if (icon != null)
                Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsetsDirectional.only(
                      end: ScreenSize().width! * 0.02),
                  child: SvgPicture.asset(
                    "assets/$icon.svg",
                    package: 'cowpay',
                    fit: BoxFit.fill,
                    color: isNotValid
                        ? Colors.red
                        : mainColor ?? Color(0xff66496A),
                  ),
                ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    itemHeight: 50.0,
                    style: TextStyle(color: Colors.black),
                    hint: Text(
                      hintText,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    items: List.generate(
                        list.length,
                        (index) => DropdownMenuItem<String>(
                              value: list[index],
                              child: new Text(list[index]),
                            )),
                    onChanged: (String? val) {
                      onChange(context, val);
                    },
                    iconEnabledColor: isNotValid
                        ? Colors.red
                        : mainColor ?? Color(0xff66496A),
                    value: value != '' ? value : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isNotValid)
          TextInputErrorView(
            errorMessage: 'categoryRequired',
          )
      ],
    );
  }
}
