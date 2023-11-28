import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/parties/vendor_model.dart';
import 'package:pos/pages/parties/party_c.dart';

class PurchaseController extends GetxController {
  Vendor selectedVendor = Vendor();

  final purchaseFormKey = GlobalKey<FormState>();
  final purchaseItemsFormKey = GlobalKey<FormState>();

  // RxList<TextEditingController> txtControllers = <TextEditingController>[].obs;

  InventoryController inventoryController = Get.find<InventoryController>();
  RxList<Map> items = <Map>[].obs;
  // {
  //   'itemName': '',
  //   'mrp': '',
  //   'rate': '',
  //   'qty': '',
  //   'category': '',
  //   'subcategory': '',
  //   'discount': '',
  //   'discountQTY': '',
  //   'cd': '',
  //   'td': '',
  //   'cgst': '',
  //   'sgst': '',
  //   'expiry': '',
  //   'hsn': '',
  //   'batch': '',
  //   'packsize': '',
  //   'manufacturer': '',
  // }

  Map singleItemData = {};

  TextEditingController itemNameTextCtr = TextEditingController();
  TextEditingController mrpTextCtr = TextEditingController();
  TextEditingController expDateTxtCtr = TextEditingController();
  TextEditingController gstTextCtr = TextEditingController();
  TextEditingController rateTextCtr = TextEditingController();
  TextEditingController qtyTextCtr = TextEditingController();
  TextEditingController cdTextCtr = TextEditingController();
  TextEditingController tdTextCtr = TextEditingController();
  TextEditingController cgstTextCtr = TextEditingController();
  TextEditingController sgstTextCtr = TextEditingController();
  TextEditingController hsnTextCtr = TextEditingController();
  TextEditingController batchTextCtr = TextEditingController();
  TextEditingController packSizeTextCtr = TextEditingController();
  TextEditingController manufacturerTextCtr = TextEditingController();
  TextEditingController discountTextCtr = TextEditingController();
  TextEditingController discountQtyTextCtr = TextEditingController();
  // TextEditingController TextCtr = TextEditingController();
  void clearFormFields() {
    itemNameTextCtr.clear();
    mrpTextCtr.clear();
    expDateTxtCtr.clear();
    gstTextCtr.clear();
    rateTextCtr.clear();
    qtyTextCtr.clear();
    cdTextCtr.clear();
    tdTextCtr.clear();
    cgstTextCtr.clear();
    sgstTextCtr.clear();
    hsnTextCtr.clear();
    batchTextCtr.clear();
    packSizeTextCtr.clear();
    manufacturerTextCtr.clear();
    discountTextCtr.clear();
    discountQtyTextCtr.clear();
    // TextEditingController TextCtr = TextEditingController();
  }

  RxInt index = 0.obs;

  final List<String> categories = [
    // 'Food and Beverages ',
    // "Personal Care and Hygiene",
    // "Household Cleaning and Care",
    // "Health and Wellness",
    // "Baby and Childcare",
    // "Confectionery and Chocolates",
    // "Beauty and Cosmetics",
    // "Pharmaceuticals",
    // "Tobacco and Cigarettes",
    "General",
    "Pharma"
  ];

  final List<String> subCategories = [
    'subcategory1',
    'subcategory2',
  ];

  String selectedCategory = '';
  String selectedSubCategory = '';

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

  void unselectSupplier() {
    selectedVendor = Vendor();
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
