library cowpay;

import 'package:cowpay/bloc/bloc/credit_card_bloc.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/formz_models/credit_card_holder_name.dart';
import 'package:cowpay/helpers/enum_models.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/ui/generic_views/text_input_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreditCardWidget extends StatelessWidget {
  final String merchantCode;
  final String merchantHash;
  final CowpayEnvironment activeEnvironment;
  final String token;
  final double amount;
  final String customerEmail;
  final String customerMobile;
  final String description;
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final double? height;

  CreditCardWidget(
      {required this.merchantCode,
      required this.merchantHash,
      required this.amount,
      required this.activeEnvironment,
      required this.token,
      required this.customerEmail,
      required this.customerMobile,
      required this.description,
      required this.customerMerchantProfileId,
      required this.merchantReferenceId,
      this.height});

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;
    FocusNode _creditCardHolderNameFocusNode = FocusNode();
    FocusNode _creditCardHolderNumberFocusNode = FocusNode();
    // Cowpay.instance.init(
    //   cowpayEnvironment: CowpayEnvironment.staging,
    //   token: token,
    //   merchantCode: merchantCode,
    //   merchantHash: merchantHash,
    // );
    return BlocProvider<CreditCardBloc>(
      create: (context) {
        return CreditCardBloc();
      },
      child: Container(
        height: height ?? (ScreenSize().height),
        width: ScreenSize().width,
        color: Colors.grey.withOpacity(0.8),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(ScreenSize().width! * 0.05),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.05)),
              child: Padding(
                padding: EdgeInsets.all(ScreenSize().width! * 0.05),
                child: Column(
                  children: [
                    _CreditCardHolderNameInput(
                      currentFocus: _creditCardHolderNameFocusNode,
                      nextFocus: _creditCardHolderNumberFocusNode,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreditCardHolderNameInput extends StatelessWidget {
  final FocusNode? currentFocus, nextFocus;

  const _CreditCardHolderNameInput(
      {/*Key key, */ this.currentFocus, this.nextFocus})
      : super(/*key: key*/);

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
          mainContext: context,
          isNotValid: isNotValid,
          obscureText: false,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.text,
          hintText: 'Card Holder Name',
          onChange: onChangeUsername,
          currentFocus: currentFocus,
          nextFocus: nextFocus,
          errorMessage: state.creditCardHolderName.error?.message,
          // showHelp: false,
          /*key: key!,*/
          // onHelpChange: onChangeHelpUsername,
          // showHelp: state.showUsernameHelp,
          // helpText: 'loginUserNameHelp',
        );
      },
    );
  }

  void onChangeUsername(BuildContext context, String value) {
    context.read<CreditCardBloc>().add(CreditCardNameChange(value));
  }
}
