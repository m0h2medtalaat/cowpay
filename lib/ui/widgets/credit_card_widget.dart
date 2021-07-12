library cowpay;

import 'package:cowpay/bloc/bloc/credit_card_bloc.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/formz_models/credit_card_cvv.dart';
import 'package:cowpay/formz_models/credit_card_expiry_month.dart';
import 'package:cowpay/formz_models/credit_card_expiry_year.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/formz_models/credit_card_number.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/models/cach_collection_response_model.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

FocusNode _creditCardHolderNameFocusNode = FocusNode();
FocusNode _creditCardNumberFocusNode = FocusNode();
FocusNode _creditCardExpiryMonthFocusNode = FocusNode();
FocusNode _creditCardExpiryYearFocusNode = FocusNode();
FocusNode _creditCardCvvFocusNode = FocusNode();

class CreditCardWidget extends StatelessWidget {
  final _creditCardHolderNameFocusNode = FocusNode();
  final _creditCardNumberFocusNode = FocusNode();
  final _creditCardExpiryMonthFocusNode = FocusNode();
  final _creditCardExpiryYearFocusNode = FocusNode();
  final _creditCardCvvFocusNode = FocusNode();

  final String description, merchantReferenceId, customerMerchantProfileId;

  final String customerEmail;

  final String customerMobile;
  final CowpayEnvironment activeEnvironment;
  final double amount;
  final double? height;
  final Color? /*backGroundColor,*/ /*cardColor,*/ buttonColor, buttonTextColor, mainColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;

  final Function(CreditCardResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  CreditCardWidget(
      {required this.amount,
      required this.activeEnvironment,
      required this.customerEmail,
      required this.customerMobile,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.height,
      this.buttonTextColor,
//      this.cardColor,
//      this.backGroundColor,
      this.buttonColor,
      this.buttonTextStyle,
      this.textFieldStyle,
      this.textFieldInputDecoration,
      this.mainColor,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    TextStyle defaultTextStyle =
        TextStyle(color: mainColor ?? Colors.black, fontSize: 14);
    TextStyle defaultHintStyle =
        TextStyle(color: mainColor?.withOpacity(0.4) ?? Color(0x9066496A), fontSize: 14);
    InputDecoration defaultInputDecoration = InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: mainColor ?? Color(0xff66496A), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: mainColor?.withOpacity(0.5) ?? Color(0x3066496A),
              width: 1.0),
        ),
//      fillColor: Colors.grey,

        isDense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        hintText: "hintText.tr()",
        hintStyle: defaultHintStyle,
        labelStyle: defaultHintStyle);

    return BlocProvider<CreditCardBloc>(
      create: (context) {
        return CreditCardBloc()
          ..add(CreditCardChargeStarted(
              merchantReferenceId: merchantReferenceId,
              customerMerchantProfileId: customerMerchantProfileId,
              amount: amount.toString(),
              customerEmail: customerEmail,
              customerMobile: customerMobile,
              description: description));
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              child: Image.asset(AssetImage("assets/page_bg.png").assetName, package: 'cowpay-package',),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: ScreenSize().height! * 0.1),
                child: Column(
                  children: [
                    Container(
//                      child: Image.asset("icon"),
                      color: Colors.red,
                      height: ScreenSize().height! * 0.3,
                      width: ScreenSize().width! * 0.6,
                    ),
                    SizedBox(
                      height: ScreenSize().height! * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width *
                                    0.05)),
                        child: Padding(
                          padding:
                              EdgeInsets.all(ScreenSize().width! * 0.05),
                          child: Column(
                            children: [
                              _CreditCardHolderNameInput(
                                style: textFieldStyle ?? defaultTextStyle,
                                inputDecoration:
                                    textFieldInputDecoration ??
                                        defaultInputDecoration,
    currentNode: _creditCardHolderNameFocusNode,
    nextNode: _creditCardNumberFocusNode,
                              ),
                              SizedBox(
                                height: ScreenSize().height! * 0.025,
                              ),
                              _CreditCardNumberInput(
                                style: textFieldStyle ?? defaultTextStyle,
                                inputDecoration:
                                    textFieldInputDecoration ??
                                        defaultInputDecoration,
    currentNode: _creditCardNumberFocusNode,
    nextNode: _creditCardExpiryMonthFocusNode
                              ),
                              SizedBox(
                                height: ScreenSize().height! * 0.025,
                              ),
                              _CreditCardExpiryMonthInput(
                                style: textFieldStyle ?? defaultTextStyle,
                                inputDecoration:
                                    textFieldInputDecoration ??
                                        defaultInputDecoration,
    currentNode: _creditCardExpiryMonthFocusNode,
    nextNode: _creditCardExpiryYearFocusNode
                              ),
                              SizedBox(
                                height: ScreenSize().height! * 0.025,
                              ),
                              _CreditCardExpiryYearInput(
                                style: textFieldStyle ?? defaultTextStyle,
                                inputDecoration:
                                    textFieldInputDecoration ??
                                        defaultInputDecoration,
    currentNode: _creditCardExpiryYearFocusNode,
    nextNode: _creditCardCvvFocusNode
                              ),
                              SizedBox(
                                height: ScreenSize().height! * 0.025,
                              ),
                              _CreditCardCvvInput(
                                style: textFieldStyle ?? defaultTextStyle,
                                inputDecoration:
                                textFieldInputDecoration ??
                                    defaultInputDecoration,
    currentNode: _creditCardCvvFocusNode,
                              ),
                              SizedBox(
                                height: ScreenSize().height! * 0.07,
                              ),
                              Container(
                                height: ScreenSize().height! * 0.08,
                                child: _ChargeButton(
                                  buttonColor: buttonColor ??
                                      mainColor ??
                                      Color(0xff66496A),
                                  buttonTextColor: buttonTextColor,
                                  buttonTextStyle: buttonTextStyle,
                                  onSuccess: (val) => onSuccess(val),
                                  onError: (error) => onError(error),
                                ),
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
    );
  }
}

class _ChargeButton extends StatelessWidget {
  final Color? buttonColor, buttonTextColor;
  final TextStyle? buttonTextStyle;
  final Function(CreditCardResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  _ChargeButton(
      {this.buttonTextStyle,
      this.buttonColor,
      this.buttonTextColor,
      required this.onSuccess,
      required this.onError});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          if (state.status.isSubmissionSuccess)
            onSuccess(state.creditCardResponseModel!);
          else if (state.status.isSubmissionFailure) onError(state.errorModel);
        });
        return state.status.isSubmissionInProgress
            ? ButtonLoadingView()
            : ButtonView(
                fontWeight: FontWeight.w300,
                title: 'COMPLETE PAYMENT',
                textColor: buttonTextColor ?? Colors.white,
                fontSize: 0.025,
                backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
                mainContext: context,
                buttonTextStyle: buttonTextStyle,
                onClickFunction: onClickSubmit,
              );
      },
    );
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    context.read<CreditCardBloc>().add(ChargeValidation(context));
  }
}

class _CreditCardHolderNameInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentNode, nextNode;

  _CreditCardHolderNameInput(
      {this.style,
      this.inputDecoration,
      required this.currentNode,
      required this.nextNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardHolderName != current.creditCardHolderName ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardHolderName.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Card Holder Name',
          onChange: onChangeCreditCardHolderName,
          currentFocus: currentNode,
          nextFocus: nextNode,
          errorMessage: state.creditCardHolderName.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardHolderName(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNameChange(value));
  }
}

class _CreditCardNumberInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentNode, nextNode;
  _CreditCardNumberInput(
      {this.style,
      this.inputDecoration,
      required this.currentNode,
      required this.nextNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardNumber != current.creditCardNumber ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardNumber.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          maxLength: 16,
          hintText: 'Card Number',
          onChange: onChangeCreditCardNumber,
          currentFocus: currentNode,
          nextFocus: nextNode,
          errorMessage: state.creditCardNumber.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardNumber(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNumberChange(value));
  }
}

class _CreditCardExpiryMonthInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentNode, nextNode;

  _CreditCardExpiryMonthInput(
      {this.style,
      this.inputDecoration,
      required this.nextNode,
      required this.currentNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardExpiryMonth != current.creditCardExpiryMonth ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardExpiryMonth.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          width: (ScreenSize().width! * 0.2),
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Card Expiry Month',
          maxLength: 2,
          onChange: onChangeCreditCardExpiryMonth,
          currentFocus: currentNode,
          nextFocus: nextNode,
          errorMessage: state.creditCardExpiryMonth.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardExpiryMonth(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardExpiryMonthChange(value));
  }
}

class _CreditCardExpiryYearInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentNode, nextNode;

  _CreditCardExpiryYearInput(
      {this.style,
      this.inputDecoration,
      required this.currentNode,
      required this.nextNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardExpiryYear != current.creditCardExpiryYear ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid =
            state.creditCardExpiryYear.invalid && state.status.isInvalid;
        return TextInputView(
          style: style,
          inputDecoration: inputDecoration,
          mainContext: context,
          isNotValid: isNotValid,
          width: (ScreenSize().width! * 0.2),
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          hintText: 'Card Expiry Year',
          maxLength: 2,
          onChange: onChangeCreditCardExpiryYear,
          currentFocus: currentNode,
          nextFocus: nextNode,
          errorMessage: state.creditCardExpiryYear.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardExpiryYear(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardExpiryYearChange(value));
  }
}

class _CreditCardCvvInput extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? inputDecoration;
  final FocusNode currentNode;
  _CreditCardCvvInput(
      {this.style, this.inputDecoration, required this.currentNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      buildWhen: (previous, current) =>
          previous.creditCardCvv != current.creditCardCvv ||
          previous.status != current.status,
      builder: (context, state) {
        bool isNotValid = state.creditCardCvv.invalid && state.status.isInvalid;
        return TextInputView(
          inputDecoration: inputDecoration,
          style: style,
          mainContext: context,
          isNotValid: isNotValid,
          onFieldSubmitted: (_) {
            onClickSubmit(context);
          },
          width: (ScreenSize().width! * 0.4),
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          maxLength: 3,
          hintText: 'Card Cvv',
          onChange: onChangeCreditCardCvv,
          currentFocus: currentNode,
          errorMessage: state.creditCardCvv.error?.message,
        );
      },
    );
  }

  void onChangeCreditCardCvv(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardCvvChange(value));
  }

  void onClickSubmit(
    BuildContext context,
  ) {
    context.read<CreditCardBloc>().add(ChargeValidation(context));
  }
}
