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

  static success(String title, body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(
          title,
          body,
          shouldIconPulse: true,
          backgroundColor: Colors.green,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 1800),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          overlayBlur: 1,
          leftBarIndicatorColor: Colors.amber,
          icon: const Icon(Icons.done_all_rounded),
        );

  static failed(String title, String body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(
          title,
          body,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 2000),
          snackPosition: SnackPosition.BOTTOM,
          shouldIconPulse: true,
          overlayBlur: 4,
          icon: const Icon(Icons.signal_cellular_connected_no_internet_4_bar_rounded),
        );

  static quickAlert(String title, String body) => Get.isSnackbarOpen
      ? Get.closeCurrentSnackbar()
      : Get.snackbar(
          title,
          body,
          duration: const Duration(seconds: 1),
        );
}
