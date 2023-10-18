import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pos/src/services/api.dart';
import 'package:pos/src/services/apiServices.dart';

class InventoryController extends GetxController {
  // List<InventoryItems> _list = [];
  List items = [];

  @override
  void onInit() async {
    items = await APIServices.getItems();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
}//END