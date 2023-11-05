import 'package:pos/src/services/apiServices.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
  // List<InventoryItems> _list = [];
  List items = [];

  RxList<Map> inventoryData = [
    {"name": "Apple cider", "price": 240.5, "gst": 10.0, "stock": 20, "qty": 1},
    {"name": "BenQ Monitor", "price": 56000.0, "gst": 28.0, "stock": 211, "qty": 1},
    {"name": "Lether belt", "price": 324.5, "gst": 18.0, "stock": 112, "qty": 1},
    {"name": "banana shake", "price": 300.0, "gst": 15.0, "stock": 14, "qty": 1},
    {"name": "Cup", "price": 49.0, "gst": 4.0, "stock": 121, "qty": 1},
    {"name": "Logitec Optical Mouse", "price": 3240.0, "gst": 34.0, "stock": 184, "qty": 1},
    {"name": "CosmicByte CB GK 03 Corona", "price": 2400.0, "gst": 22.0, "stock": 12, "qty": 1},
    {"name": "Apple53245234", "price": 32400.0, "gst": 34.0, "stock": 1854, "qty": 1},
    {"name": "Vinegar", "price": 32.0, "gst": 4.0, "stock": 1548, "qty": 1},
    {"name": "Frootieeeee", "price": 24.0, "gst": 14.0, "stock": 148, "qty": 1},
  ].obs;

  @override
  void onInit() async {
    items = await APIServices.getItems();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
} //END
