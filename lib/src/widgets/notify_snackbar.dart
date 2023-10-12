import 'package:flutter/material.dart';
import 'package:get/get.dart';

void notifyUser(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

showSnackbar(String title, String body) => Get.isSnackbarOpen
    ? Get.closeCurrentSnackbar()
    : Get.snackbar(
        title,
        body,
      );

showQuickAlert(String title, String body) => Get.isSnackbarOpen
    ? Get.closeCurrentSnackbar()
    : Get.snackbar(
        title,
        body,
        duration: const Duration(seconds: 1),
      );
