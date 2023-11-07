import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pos/pages/otp/otp_c.dart';
import 'package:pos/src/utils/hapics.dart';

class OTPScreen extends GetWidget<OTPController> {
  OTPScreen({super.key});

  // final Map data;

  verifyOTP() {
    // switch (widget.data["role"]) {
    //   case 'SALESMAN':
    //     Get.offAllNamed('/SALESMAN');
    //     break;
    //   case 'STORE_MANAGER':
    //     Get.offAllNamed('/STORE_MANAGER');
    //     break;
    //   case 'STORE_OWNER':
    //     Get.offAllNamed('/STORE_OWNER');
    //     break;
    //   case 'ADMIN':
    //     Get.offAllNamed('/ADMIN');
    //     break;
    //   default:
    //     Get.offAllNamed('/login');
    // }
  }

  @override
  Widget build(BuildContext context) {
    log(controller.args.toString());

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    const int otpLength = 8;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // Text("Hello"),
                Text("Hello ${controller.args['name']},", style: Theme.of(context).textTheme.headlineSmall),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text("OTP has been sent to:"),
                ),
                Text("${controller.args['email']}", style: Theme.of(context).textTheme.titleLarge),
                Text("check your mail", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const Text("Enter your OTP here:"),
            FractionallySizedBox(
              widthFactor: 1,
              child: Form(
                key: controller.formKey,
                child: Pinput(
                  length: otpLength,
                  controller: controller.pinController,
                  focusNode: controller.focusNode,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    return value?.length == otpLength ? null : 'Incorrect OTP';
                  },
                  onClipboardFound: (value) {
                    debugPrint('onClipboardFound: $value');
                    controller.pinController.setText(value);
                  },
                  keyboardAppearance: Brightness.dark,
                  hapticFeedbackType: Haptics.heavy(),
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                    controller.verifyUserOTP();
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: focusedBorderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: Colors.transparent),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// ! OTP Stype fields
//  return Scaffold(
//       body: FractionallySizedBox(
//         widthFactor: 1,
//         child: Pinput(
//           length: 5,
//           pinAnimationType: PinAnimationType.slide,
//           controller: controller,
//           focusNode: focusNode,
//           defaultPinTheme: const PinTheme(
//             width: 56,
//             height: 56,
//             textStyle: TextStyle(
//               fontSize: 22,
//               color: Color.fromRGBO(30, 60, 87, 1),
//             ),
//             decoration: BoxDecoration(),
//           ),
//           showCursor: true,
//           cursor: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 56,
//                 height: 3,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ],
//           ),
//           preFilledWidget: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 56,
//                 height: 3,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );