import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MassengerScaffold {
  static notifyUser(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class Snackbar {
  static trigger(String title, String body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(
          title,
          body,
        );
  static failed(String title, String body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(title, body,
          backgroundColor: Colors.pinkAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          overlayBlur: 8,
          icon: const Icon(Icons.sms_failed_outlined));

  static quickAlert(String title, String body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(
          title,
          body,
          duration: const Duration(seconds: 1),
        );
}
