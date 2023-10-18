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

  void share() async {
    final result =
        await Share.shareWithResult(textMessage.value.trim(), subject: "Marketing Test (Paperlessly)");

    result.status == ShareResultStatus.success
        ? showSnackbar("Thank you", "Thank you for using our services to market yourself")
        : showSnackbar("Sharing failed", "Unable to share due to cancellation");
  }

  shareAssetImage(String asset) async {
    final bytes = await rootBundle.load(asset);
    final list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);

    Share.shareFiles(['${file.path}'], text: 'Discount and offers at \${businessName}');
  } // END

  void saveAssetImageToDevice(int index) async {
    final bytes = await rootBundle.load("assets/${index + 1}.jpg");
    final list = bytes.buffer.asUint8List();

    final localDir = await getApplicationDocumentsDirectory();
    final file = await File('${localDir.path}/${index + 1}.jpg').create();
    // log(file.path);
    final write = file.writeAsBytesSync(list);
  } // END
} //

