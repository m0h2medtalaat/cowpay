library cowpay;

import 'package:cowpay/bloc/bloc/cash_collection_bloc.dart';
import 'package:cowpay/bloc/event/cash_collection_event.dart';
import 'package:cowpay/bloc/state/cash_collection_state.dart';
import 'package:cowpay/formz_models/num_text_input.dart';
import 'package:cowpay/formz_models/text_input.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/models/cash_collection_response_model.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/text_input_error_view.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CashCollectionWidget extends StatelessWidget {
  final _cashDistrictFocusNode = FocusNode();
  final _cashAddressFocusNode = FocusNode();
  final _cashFloorFocusNode = FocusNode();
  final _cashApartmentFocusNode = FocusNode();
  final _cashCityCodeFocusNode = FocusNode();
  final String customerName,
      description,
      merchantReferenceId,
      customerMerchantProfileId,
      customerEmail,
      customerMobile;

  final CowpayEnvironment activeEnvironment;
  final double amount;
  final double? height;
  final Color? /*backGroundColor, cardColor,*/ buttonColor,
      buttonTextColor,
      mainColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;

  final Function(CashCollectionResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  CashCollectionWidget(
      {required this.amount,
      required this.activeEnvironment,
      required this.customerEmail,
      required this.customerMobile,
      required this.customerName,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.height,
      this.buttonTextColor,
      this.mainColor,
      // this.cardColor,
      // this.backGroundColor,
      this.buttonColor,
      this.buttonTextStyle,
      this.textFieldStyle,
      this.textFieldInputDecoration,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    return BlocProvider<CashCollectionBloc>(
      create: (context) {
        return CashCollectionBloc()
          ..add(CashCollectionChargeStarted(
              merchantReferenceId: merchantReferenceId,
              customerMerchantProfileId: customerMerchantProfileId,
              amount: amount.toString(),
              customerEmail: customerEmail,
              customerMobile: customerMobile,
              customerName: customerName,
              description: description));
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage(
                          "assets/page_bg.png",
                          package: 'cowpay',
                        ),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenSize().height! * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Image(
                            image: AssetImage(
                          'assets/cowpay_logo.png',
                          package: 'cowpay',
                        )),
                        height: ScreenSize().height! * 0.2,
                        width: ScreenSize().width! * 0.47,
                      ),
                      SizedBox(
                        height: ScreenSize().height! * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.05)),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                            child: Column(
                              children: [
                                _DistrictInput(
                                  mainColor: mainColor,
                                  style: textFieldStyle,
                                  inputDecoration: textFieldInputDecoration,
                                  currentFocusNode: _cashDistrictFocusNode,
                                  nextFocusNode: _cashAddressFocusNode,
                                ),
                                SizedBox(
                                  height: ScreenSize().height! * 0.025,
                                ),
                                _AddressInput(
                                  mainColor: mainColor,
                                  style: textFieldStyle,
                                  inputDecoration: textFieldInputDecoration,
                                  currentFocusNode: _cashAddressFocusNode,
                                  nextFocusNode: _cashFloorFocusNode,
                                ),
                                SizedBox(
                                  height: ScreenSize().height! * 0.025,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _FloorInput(
                                        mainColor: mainColor,
                                        style: textFieldStyle,
                                        inputDecoration:
                                            textFieldInputDecoration,
                                        nextFocusNode: _cashApartmentFocusNode,
                                        currentFocusNode: _cashFloorFocusNode,
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenSize().width! * 0.012,
                                    ),
                                    Expanded(
                                      child: _ApartmentInput(
                                        mainColor: mainColor,
                                        style: textFieldStyle,
                                        inputDecoration:
                                            textFieldInputDecoration,
                                        currentFocusNode:
                                            _cashApartmentFocusNode,
                                        nextFocusNode: _cashCityCodeFocusNode,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenSize().height! * 0.025,
                                ),
                                _CityCodeDropDown(mainColor:  mainColor),
                                SizedBox(
                                  height: ScreenSize().height! * 0.04,
                                ),
                                _ChargeButton(
                                  buttonColor: mainColor ?? Color(0xff66496A),
                                  amount: amount,
                                  buttonTextColor: buttonTextColor,
                                  buttonTextStyle: buttonTextStyle,
                                  onSuccess: (val) => onSuccess(val),
                                  onError: (error) => onError(error),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CityCodeDropDown extends StatelessWidget {
  Color? mainColor;

  _CityCodeDropDown({this.mainColor});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
        buildWhen: (previous, current) =>
        previous.cityKey != current.cityKey ||
            previous.checkValidation != current.checkValidation,
        builder: (context, state) {
          bool isNotValid =
              state.status.isInvalid && state.cashCollectionCityCode.invalid;
          return cityCodeDropdownMenu(state, context, isNotValid);
        });
  }

  Widget cityCodeDropdownMenu(
      CashCollectionState state, BuildContext context, bool isNotValid) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: isNotValid
                    ? Colors.red
                    : mainColor?.withOpacity(0.3) ?? Color(0x3066496A),
                width: 1,
              ),
              color: Colors.white),
          child: Row(
            children: [
              /*Container(
                width: 25.ssp,
                height: 25.ssp,
                margin: EdgeInsetsDirectional.only(end: 0.02.sw),
                child: Image(
                  image: AssetImage('resources/images/diploma.png'),
                  color: isNotValid
                      ? Colors.red
                      : Color(0xff66496A),
                ),
              ),*/
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    itemHeight: 50.0,
                    style: TextStyle(color: mainColor ?? Color(0xff66496A)),
                    dropdownColor: mainColor!=null?Colors.white:Color(0xffF0EDF0),
                    hint: Text(
                      'city code',
                      style: TextStyle(
                          color: /*mainColor?.withOpacity(0.4) ??*/ Color(0x9066496A),
                          fontSize: 14),
                    ),
                    items: testList.entries.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(e.key),
                      );
                    }).toList(),
                    onChanged: (String? key) {
                      context.read<CashCollectionBloc>().add(CashCollectionCityKeyChange(key!));
                    },
                    value: state.cityKey,
                    iconEnabledColor: isNotValid
                        ? Colors.red
                        : Color(0x9066496A),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isNotValid)
          TextInputErrorView(
            errorMessage: 'inputRequired',
          )
      ],
    );
  }
}

class _ChargeButton extends StatelessWidget {
  final Color? buttonColor, buttonTextColor;
  final TextStyle? buttonTextStyle;
  final double amount;
  final Function(CashCollectionResponseModel cashCollectionModel) onSuccess;
  final Function(dynamic error) onError;

  _ChargeButton(
      {this.buttonTextStyle,
      this.buttonColor,
      this.buttonTextColor,
      required this.onSuccess,
      required this.onError,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          if (state.status.isSubmissionSuccess)
            onSuccess(state.cashCollectionResponseModel!);
          else if (state.status.isSubmissionFailure) onError(state.errorModel);
        });
        return state.status.isSubmissionInProgress
            ? ButtonLoadingView()
            : ButtonView(
                fontWeight: FontWeight.w300,
                // title: 'Charge',
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize().width! * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CHARGE",
                          style: buttonTextStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 0.025 * ScreenSize().height!,
                                  color: Colors.white),
                          textScaleFactor: 1),
                      Text("$amount EGP",
                          style: buttonTextStyle ??
                              TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 0.025 * ScreenSize().height!,
                                  color: Colors.white),
                          textScaleFactor: 1)
                    ],
                  ),
                ),
                textColor: buttonTextColor ?? Colors.white,
                fontSize: 0.025,
                backgroundColor: buttonColor,
                mainContext: context,
                buttonTextStyle: buttonTextStyle,
                onClickFunction: onClickLogin,
              );
      },
    );
  }

  void onClickLogin(
    BuildContext context,
  ) {
    context.read<CashCollectionBloc>().add(ChargeValidation(context));
  }
}

class _DistrictInput extends StatelessWidget {
  final TextStyle? style;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final InputDecoration? inputDecoration;

  _DistrictInput(
      {this.style,
      this.inputDecoration,
      required this.currentFocusNode,
      required this.nextFocusNode,
      Color? mainColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionDistrict != current.cashCollectionDistrict ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionDistrict.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'District',
          onChange: onCashCollectionDistrictChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionDistrict.error?.message,
        );
      },
    );
  }

  void onCashCollectionDistrictChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionDistrictChange(value));
  }
}

class _AddressInput extends StatelessWidget {
  final TextStyle? style;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final InputDecoration? inputDecoration;

  _AddressInput(
      {this.style,
      this.inputDecoration,
      required this.currentFocusNode,
      required this.nextFocusNode,
      Color? mainColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionAddress != current.cashCollectionAddress ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionAddress.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Address',
          onChange: onCashCollectionAddressChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionAddress.error?.message,
        );
      },
    );
  }

  void onCashCollectionAddressChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionAddressChange(value));
  }
}

class _FloorInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode nextFocusNode;
  final FocusNode currentFocusNode;

  _FloorInput(
      {this.style,
      this.inputDecoration,
      required this.nextFocusNode,
      required this.currentFocusNode,
      Color? mainColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionFloor != current.cashCollectionFloor ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionFloor.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Floor',
          onChange: onCashCollectionFloorChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionFloor.error?.message,
        );
      },
    );
  }

  void onCashCollectionFloorChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionFloorChange(value));
  }
}

class _ApartmentInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode nextFocusNode;
  final FocusNode currentFocusNode;

  _ApartmentInput(
      {this.style,
      this.inputDecoration,
      required this.nextFocusNode,
      required this.currentFocusNode,
      Color? mainColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionApartment != current.cashCollectionApartment ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionApartment.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Apartment',
          onChange: onCashCollectionApartmentChange,
          currentFocus: currentFocusNode,
          nextFocus: nextFocusNode,
          errorMessage: state.cashCollectionApartment.error?.message,
        );
      },
    );
  }

  void onCashCollectionApartmentChange(BuildContext context, String value) {
    context
        .read<CashCollectionBloc>()
        .add(CashCollectionApartmentChange(value));
  }
}

class _CityCodeInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentFocusNode;

  _CityCodeInput({
    this.style,
    this.inputDecoration,
    required this.currentFocusNode,
    Color? mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashCollectionBloc, CashCollectionState>(
      buildWhen: (previous, current) =>
          previous.cashCollectionCityCode != current.cashCollectionCityCode ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.cashCollectionCityCode.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'City code',
          onChange: onCashCollectionCityCodeChange,
          currentFocus: currentFocusNode,
          onFieldSubmitted: (_) {
            onClickSubmit(context);
          },
          errorMessage: state.cashCollectionCityCode.error?.message,
        );
      },
    );
  }

  void onCashCollectionCityCodeChange(BuildContext context, String value) {
    context.read<CashCollectionBloc>().add(CashCollectionCityKeyChange(value));
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    context.read<CashCollectionBloc>().add(ChargeValidation(context));
  }
}
