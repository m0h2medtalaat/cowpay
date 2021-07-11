// import 'package:cowpay/helpers/enum_models.dart';
// import 'package:cowpay/ui/generic_views/button_view.dart';
// import 'package:flutter/material.dart';
//
// class DialogView extends StatelessWidget {
//   final String? content, actionText, cancelText;
//   final Function(BuildContext)? onCLick, extraOnCancel;
//   final BuildContext? mainContext;
//   final DialogType? dialogType;
//
//   const DialogView(
//       {this.content,
//       this.actionText,
//       this.onCLick,
//       this.mainContext,
//       this.dialogType,
//       this.extraOnCancel,
//       this.cancelText = 'cancel'})
//       : super();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       backgroundColor: Colors.transparent,
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           buildTopBackground(),
//           buildContent(context),
//           buildImage(),
//         ],
//       ),
//     );
//   }
//
//   Container buildTopBackground() {
//     return Container(
//       width: 0.65.sw,
//       height: 0.1.sh,
//       margin: EdgeInsets.only(top: 0.027.sh),
//       decoration: BoxDecoration(
//           color: dialogType!.color, borderRadius: BorderRadius.circular(20.0)),
//     );
//   }
//
//   Container buildImage() {
//     return Container(
//       width: 0.08.sh,
//       height: 0.08.sh,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       child: dialogType!.image,
//     );
//   }
//
//   Widget buildContent(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 0.04.sh),
//           width: 1.sw,
//           padding: EdgeInsets.only(
//             top: 0.06.sh,
//           ),
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 content!.tr(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: ConstantColors.c888888,
//                   fontFamily: 'fontFamily'.tr(),
//                   height: 1.2,
//                 ),
//               ),
//               SizedBox(
//                 height: 0.04.sh,
//               ),
//               if (actionText != null) buildActions(context),
//             ],
//           ),
//         ),
//         if (actionText == null)
//           Container(
//               margin: EdgeInsetsDirectional.only(top: 0.04.sh, start: 0.68.sw),
//               child: IconButton(
//                   icon: Icon(
//                     Icons.cancel_outlined,
//                     color: ConstantColors.cD60A0A,
//                     size: 0.07.sw,
//                   ),
//                   onPressed: () => Navigator.pop(context)))
//       ],
//     );
//   }
//
//   Container buildActions(BuildContext context) {
//     return Container(
//       // height: 0.15.sh,
//       decoration: BoxDecoration(
//           color: ConstantColors.c39375A,
//           borderRadius: BorderRadiusDirectional.only(
//               bottomEnd: Radius.circular(20),
//               bottomStart: Radius.circular(20))),
//       child: Column(
//         children: [
//           CustomPaint(
//               size: Size(0.08.sw, 0.018.sh), painter: DrawTriangleShape()),
//           Container(
//             margin: EdgeInsets.only(bottom: 0.02.sh, top: 0.01.sh),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 actionText != null
//                     ? buildAction(
//                         context,
//                       )
//                     : SizedBox(
//                         width: 0.3.sw,
//                       ),
//                 buildCancel(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildAction(
//     BuildContext context,
//   ) {
//     return Container(
//       width: 0.3.sw,
//       child: ButtonView(
//         title: actionText!,
//         backgroundColor: dialogType!.color,
//         height: 0.045,
//         mainContext: mainContext!,
//         onClickFunction: callCallaBack,
//       ),
//     );
//   }
//
//   Widget buildCancel(
//     BuildContext context,
//   ) {
//     return Container(
//       width: 0.3.sw,
//       child: ButtonView(
//         title: cancelText!.tr(),
//         backgroundColor: ConstantColors.c39375A,
//         borderColor: Colors.white,
//         height: 0.045,
//         mainContext: context,
//         onClickFunction: onCancelClick,
//       ),
//     );
//   }
//
//   void callCallaBack(BuildContext context) {
//     Navigator.pop(context);
//     onCLick!(mainContext!);
//   }
//
//   void onCancelClick(BuildContext context) {
//     Navigator.pop(context);
//     if (extraOnCancel != null) extraOnCancel!(mainContext!);
//   }
//
//   static Future<void> dialog(
//     BuildContext _context,
//     String content,
//     DialogType dialogType, {
//     String? actionText,
//     String cancelText = 'cancel',
//     Function(BuildContext)? onCLick,
//     bool barrierDismissible = true,
//     Function(BuildContext)? extraOnCancel,
//   }) {
//     debugPrint('Error Message:  $content');
//     return showDialog(
//         barrierDismissible: barrierDismissible,
//         context: _context,
//         builder: (BuildContext context) {
//           return DialogView(
//             dialogType: dialogType,
//             content: content,
//             mainContext: _context,
//             actionText: actionText,
//             extraOnCancel: extraOnCancel,
//             onCLick: onCLick,
//             cancelText: cancelText,
//           );
//         });
//   }
// }
