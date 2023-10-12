import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class ManageUserController extends GetxController {
  final TextEditingController idcontroller = TextEditingController();

  final TextEditingController nameTxtController = TextEditingController();
  final TextEditingController mobileTxtController = TextEditingController();
  final TextEditingController emailTxtController = TextEditingController();
  final TextEditingController passTxtController = TextEditingController();

  RxBool isObscure = false.obs;

  final List<String> roles = ['SALESMAN', 'STORE_MANAGER', 'STORE_OWNER', "ADMIN"];
  RxString selectedRole = ''.obs;
  String defaultRole = '';

  final signupKey = GlobalKey<FormState>();

  addUser() async {
    var response = await APIServices.addNewUser(
      nameTxtController.text,
      emailTxtController.text,
      selectedRole.value,
      mobileTxtController.text,
      passTxtController.text,
    );
    log(response.statusCode.toString());
    var body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log(body.toString());
      // Get.offAllNamed(
      Get.toNamed(
        '/otp',
        arguments: {
          'name': nameTxtController.text,
          'email': emailTxtController.text,
          'token': body['verifyToken'],
        },
      );
    } else {
      log(body.toString());
      showSnackbar(body["type"], body['message']);
    }

    //  "email": "string",
    // "mobile": "string",
    // "name": "string",
    // "password": "string",
    // "role": "string",
  }

  //
} // END
