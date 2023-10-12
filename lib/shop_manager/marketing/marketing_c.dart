import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class MarketingController extends GetxController {
  RxString textMessage = "Hello There, its a marketing message".obs;
  List<String> images = ['', ''];

  void share() async {
    final result =
        await Share.shareWithResult(textMessage.value.trim(), subject: "Marketing Test (Paperlessly)");

    result.status == ShareResultStatus.success
        ? showSnackbar("Thank you", "Thank you for using our services to market yourself")
        : showSnackbar("Sharing failed", "Unable to share due to cancellation");
  }

  shareAssetImage(String asset) async {
    // await Share.shareXFiles([XFile(asset)], text: 'Great picture');

    final result = await Share.shareXFiles([
      // getImageFileFromAssets(asset)
    ], text: 'Great picture');

    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
  } // END

  void saveAssetImageToDevice(int index) async {
//
  } // END

  // shareLink() async {
  //   await Share.share('check out my website https://ujjawal.codes', subject: 'Look what I made!');
  // }
} //

class WriteDataToStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeImage(String bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension

    var status = await Permission.storage.status;
    log(status.toString());
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    File file = File('$path/$name');
    print("Save file");

    // Write the data in the file you have created
    return file.writeAsString(bytes);
  }
}
