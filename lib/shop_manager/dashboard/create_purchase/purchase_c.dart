import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/inventory/inventory_c.dart';
import 'package:pos/shop_manager/parties/vendor_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';

class PurchaseController extends GetxController {
  //
  Vendor selectedVendor = Vendor();

  final purchaseFormKey = GlobalKey<FormState>();

  InventoryController inventoryController = Get.find<InventoryController>();
  RxList<Map> items = <Map>[{}, {}].obs;

  TextEditingController dateTxtCtr = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController gst = TextEditingController();
  // TextEditingController dateTxtCtr = TextEditingController();
  // TextEditingController dateTxtCtr = TextEditingController();

  // RxInt index = 0.obs;
  // int maxIndex = 2;

  @override
  void onInit() {
    PartyController partyController = Get.put(PartyController());
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

// { // Purchase invoice payload
//     "businessDetails": {
//         "id": 1
//     },
//     "category": "Pharma",
//     "items": [
//         {
//             "product": {
//                 "id": 1,
//                 "name": "Pendul kast",
//                 "type": "TABLET",
//                 "category": "Pharma",
//                 "subCategory": "dummySubCategory",
//                 "hsn": 4343,
//                 "manufacturer": "LOC_manufacturer",
//                 "unit": "string",
//                 "batchNum": "SD7DF8CD2",
//                 "discQty": 5,
//                 "discountPerProduct": 2,
//                 "loc": "LOC",
//                 "mrp": 300,
//                 "rate": 300,
//                 "totalAmount": 3000,
//                 "td": 23,
//                 "cd": 2,
//                 "quantityParent": 8,
//                 "quantityChild": 0,
//                 "quantityMax": 10,
//                 "vendorId": 8,
//                 "expiry": "2024-09-01T05:30:00.000+00:00"
//             }
//         }
//     ],
//     "preCreatedDate": "2023-11-06T07:18:26.891Z",
//     "preCreatedInvoice": "FT3902393",
//     "salesMan": "Ram Kumar",
//     "vendor": {
//         "id": 8
//     }
// }
} // END PurchaseController
