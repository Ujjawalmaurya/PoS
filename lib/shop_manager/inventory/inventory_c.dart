import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:pos/shop_manager/inventory/item_model.dart';
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

  static
//  Future<List<InventoryItems>>
      getItems() async {
    Uri uri = Uri.parse("http://dummyjson.com/products");
    try {
      var res = await http.get(uri, headers: BaseURL.header);
      log(res.statusCode.toString());
      if (res.statusCode == 200) {
        final List result = json.decode(res.body)["products"];
        log(result.toString());
        // _list = result.map((e) => InventoryItems.fromJson(e)).toList();
        return result;
      } else {
        throw Exception('response not oke: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }
  //
}//END