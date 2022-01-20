library cowpay;

import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/cowpay_bloc.dart';
import 'bloc/event/cowpay_event.dart';
import 'bloc/state/cowpay_state.dart';
import 'helpers/localization.dart';
import 'helpers/screen_size.dart';
import 'models/credit_card_response_model.dart';

export 'package:cowpay/api_calls/exceptions.dart';
export 'package:cowpay/helpers/enum_models.dart';

class Cowpay extends StatefulWidget {
  Cowpay({
    Key? key,
    required this.description,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.customerEmail,
    required this.customerMobile,
    required this.activeEnvironment,
    required this.amount,
    required this.customerName,
    this.height,
    this.buttonColor,
    this.buttonTextColor,
    this.mainColor,
    this.buttonTextStyle,
    this.textFieldStyle,
    this.textFieldInputDecoration,
    this.localizationCode,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);
  // double amount = 150.0;
  // String customerEmail = "example@mail.com";
  // String customerMobile = "01068890002";
  // String description = "description";
  // String customerMerchantProfileId = "ExmpleId122345682";

  final String description, merchantReferenceId, customerMerchantProfileId;

  final String customerEmail, customerName;

  final String customerMobile;
  final CowpayEnvironment activeEnvironment;
  final double amount;
  final double? height;
  final Color? /*backGroundColor,*/ /*cardColor,*/ buttonColor,
      buttonTextColor,
      mainColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;
  final LocalizationCode? localizationCode;
  final Function(CreditCardResponseModel creditCardResponseModel) onSuccess;
  final Function(dynamic error) onError;

  @override
  State<Cowpay> createState() => _CowpayState();
}

class _CowpayState extends State<Cowpay> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().height = MediaQuery.of(context).size.height;
    ScreenSize().width = MediaQuery.of(context).size.width;

    if (widget.localizationCode == LocalizationCode.ar) {
      Localization().localizationMap = localizationMapAr;
      Localization().localizationCode = LocalizationCode.ar;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: widget.localizationCode == LocalizationCode.ar
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(Localization().localizationMap["paymentMethod"]),
            backgroundColor: Color(0xff66496A),
          ),
          body: DefaultTabController(
            length: 2,
            child: BlocProvider<CowpayBloc>(
              create: (context) {
                return CowpayBloc();
              },
              child: Column(
                children: [
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CreditCardWidget(
                            localizationCode: LocalizationCode.ar,
                            amount: widget.amount,
                            customerEmail: widget.customerEmail,
                            customerMobile: widget.customerMobile,
                            description: widget.description,
                            customerMerchantProfileId:
                                widget.customerMerchantProfileId,
                            merchantReferenceId: "11",
                            activeEnvironment: CowpayEnvironment.staging,
                            onSuccess: (val) {
                              debugPrint(val.statusDescription);
                              // Navigator.pop(context);
                            },
                            onError: (val) {
                              debugPrint(val.toString());
                            },
                          ),
                          CreditCardWidget(
                            localizationCode: LocalizationCode.ar,
                            amount: widget.amount,
                            customerEmail: widget.customerEmail,
                            customerMobile: widget.customerMobile,
                            description: widget.description,
                            customerMerchantProfileId:
                                widget.customerMerchantProfileId,
                            merchantReferenceId: "11",
                            activeEnvironment: CowpayEnvironment.staging,
                            onSuccess: (val) {
                              debugPrint(val.statusDescription);
                              // Navigator.pop(context);
                            },
                            onError: (val) {
                              debugPrint(val.toString());
                            },
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return BlocBuilder<CowpayBloc, CowpayState>(
        buildWhen: (previous, current) =>
            previous.tabCurrentIndex != current.tabCurrentIndex,
        builder: (context, state) {
          return Container(
              width: ScreenSize().width!,
              height: ScreenSize().height! * 0.2,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (ScreenSize().width! * 0.01),
                      vertical: (ScreenSize().height! * 0.02)),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: (ScreenSize().width! * 0.01),
                              vertical: (ScreenSize().height! * 0.01)),
                          child: GestureDetector(
                            onTap: () {
                              if (state.tabCurrentIndex != index) {
                                context
                                    .read<CowpayBloc>()
                                    .add(ChangeTabCurrentIndexEvent(index));

                                _tabController.animateTo(index);
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                width: (ScreenSize().width! * 0.2),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  alignment: AlignmentDirectional.center,
                                  constraints: BoxConstraints.expand(
                                      width: ScreenSize().width! * 0.4),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenSize().height! * 0.03),
                                    child: Text(
                                      index == 0 ? 'Credit' : 'fawry',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: state.tabCurrentIndex == index
                                              ? Colors.red
                                              : Colors.deepPurple),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))));
        });
  }
}
