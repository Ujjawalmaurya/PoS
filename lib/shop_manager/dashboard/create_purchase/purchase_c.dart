import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/add_party/vendor_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';

class PurchaseController extends GetxController {
  //
  Vendor selectedVendor = Vendor();

  @override
  void onInit() {
    PartyController controller = Get.put(PartyController());
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void updateSupplierSelection(Vendor supplier) {
    selectedVendor = supplier;
    update();
  }
  //
} // END PurchaseController
