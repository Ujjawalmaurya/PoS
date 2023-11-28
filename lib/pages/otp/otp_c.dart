import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class OTPController extends GetxController {
// args
  Map args = Get.arguments;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void verifyUserOTP() async {
    var response = await APIServices.verifyOTP(pinController.text, args['token']);
    log(response.statusCode.toString());
    var body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log(body.toString());
      Get.back();
      Snackbar.quickAlert("${body['name']} added",
          "E-mail: ${body['email']}, Mobile: ${body['mobile']} with Role: ${body['role']}");
      //
    } else {
      log(body.toString());
      Get.back();
      Snackbar.trigger(body['type'], body['message']);
    }
  }

  //
} // END
