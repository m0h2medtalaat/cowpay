library cowpay;

import 'package:cowpay/bloc/bloc/credit_card_bloc.dart';
import 'package:cowpay/bloc/event/credit_card_event.dart';
import 'package:cowpay/bloc/state/credit_card_state.dart';
import 'package:cowpay/helpers/cowpay_helper.dart';
import 'package:cowpay/helpers/localization.dart';
import 'package:cowpay/helpers/screen_size.dart';
import 'package:cowpay/models/fawry_response_model.dart';
import 'package:cowpay/ui/generic_views/button_loading_view.dart';
import 'package:cowpay/ui/generic_views/button_view.dart';
import 'package:cowpay/ui/generic_views/cowpay_payment_option_card.dart';
import 'package:cowpay/ui/widgets/fawry_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

// import 'bloc/bloc/cowpay_bloc.dart';
// import 'bloc/event/cowpay_event.dart';
// import 'bloc/state/cowpay_state.dart';
// import 'helpers/localization.dart';
// import 'helpers/screen_size.dart';
// import 'models/credit_card_response_model.dart';

export 'package:cowpay/api_calls/exceptions.dart';
export 'package:cowpay/helpers/enum_models.dart';

class FawryScreen extends StatelessWidget {
  final FawryResponseModel responseModel;


  FawryScreen({required this.responseModel});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Localization().localizationCode == LocalizationCode.ar
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // title: Text(Localization().localizationMap["paymentMethod"]),
          backgroundColor: Color(0xff3D1A54),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenSize().height! * 0.25,
                  ),
                  Text(
                    'Fawry Code',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    responseModel.paymentGatewayReferenceId ?? '',
                    style: TextStyle(
                        color: Color(0xff3D1A54),
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize().width! * 0.25),
                    child: ButtonView(
                      fontWeight: FontWeight.w300,
                      // title: 'PAY  $amount EGP',
                      child: Text(Localization().localizationMap["copyCode"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 0.025 * ScreenSize().height!,
                              color: Colors.white),
                          textScaleFactor: 1),
                      textColor: Colors.white,
                      fontSize: 0.025,
                      backgroundColor: Color(0xff3D1A54).withOpacity(0.86),
                      mainContext: context,
                      // buttonTextStyle: buttonTextStyle,
                      onClickFunction: (context) {
                        Clipboard.setData(ClipboardData(text: responseModel.paymentGatewayReferenceId))
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Number Copied')));
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize().width! * 0.03),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Localization().localizationMap["paymentSteps"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              Localization().localizationMap["FawrySteps1"],
                              style: TextStyle(
                                  color: Color(0xff9B9B9C), fontSize: 15),
                            ),
                            Text(
                              Localization().localizationMap["FawrySteps2"],
                              style: TextStyle(
                                  color: Color(0xff9C9C9D), fontSize: 15),
                            ),
                            Text(
                              Localization().localizationMap["FawrySteps3"],
                              style: TextStyle(
                                  color: Color(0xff9B9B9C), fontSize: 15),
                            ),
                            Text(
                              Localization().localizationMap["FawrySteps4"],
                              style: TextStyle(
                                  color: Color(0xff9B9B9C), fontSize: 15),
                            ),
                            Text(
                              Localization().localizationMap["FawrySteps5"],
                              style: TextStyle(
                                  color: Color(0xff9B9B9C), fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize().width! * 0.03),
                  child: CowpayPaymentOptionsCard(),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
