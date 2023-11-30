import 'dart:developer';

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

  Map singleItemData = {};

  TextEditingController itemNameTextCtr = TextEditingController(text: "Dummy name 1");
  TextEditingController mrpTextCtr = TextEditingController(text: '453');
  TextEditingController itemExpiryDateTxtCtr = TextEditingController(text: "144123");
  TextEditingController purchaseDateTxtCtr = TextEditingController(text: "144123");
  // TextEditingController gstTextCtr = TextEditingController(text: " 1223");
  TextEditingController rateTextCtr = TextEditingController(text: "1143");
  TextEditingController qtyTextCtr = TextEditingController(text: " 23");
  TextEditingController cdTextCtr = TextEditingController(text: "23");
  TextEditingController tdTextCtr = TextEditingController(text: "12");
  TextEditingController cgstTextCtr = TextEditingController(text: "3");
  TextEditingController sgstTextCtr = TextEditingController(text: "1");
  TextEditingController hsnTextCtr = TextEditingController(text: " 14123");
  TextEditingController batchTextCtr = TextEditingController(text: "314132");
  TextEditingController packSizeTextCtr = TextEditingController(text: "42");
  TextEditingController manufacturerTextCtr = TextEditingController(text: "Soke manufaturesad23");
  TextEditingController discountTextCtr = TextEditingController(text: "13");
  TextEditingController discountQtyTextCtr = TextEditingController(text: "12");
  TextEditingController locTextCtr = TextEditingController();
  // TextEditingController TextCtr = TextEditingController();

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

  String defaultCategory = '';
  String defaultSubCategory = '';

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
    log("${selectedVendor.supplierName} Selected");
    update();
  }

  void unselectSupplier() {
    selectedVendor = Vendor();
    update();
  }

  void clearFormFields() {
    // purchaseFormKey.currentState!.reset();
    itemNameTextCtr.clear();
    mrpTextCtr.clear();
    itemExpiryDateTxtCtr.clear();
    // cgstTextCtr.clear();
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

  void insertItem() {
    items.add({
      "name": itemNameTextCtr.text,
      "type": "TABLET",
      "category": selectedCategory,
      "subCategory": selectedSubCategory,
      "hsn": hsnTextCtr,
      "manufacturer": manufacturerTextCtr.text,
      "unit": "string",
      "batchNum": batchTextCtr.text,
      "discQty": discountQtyTextCtr,
      "discountPerProduct": discountTextCtr.text,
      "loc": locTextCtr.text,
      "mrp": mrpTextCtr.text,
      "rate": rateTextCtr.text,
      "totalAmount": 3000,
      "td": tdTextCtr.text,
      "cd": cdTextCtr.text,
      "quantityParent": 8,
      "quantityChild": 0,
      "quantityMax": qtyTextCtr.text,
      "vendorId": selectedVendor.id,
      "expiry": itemExpiryDateTxtCtr,
    });
    log(items.toString());
    singleItemData = {};
    clearFormFields();
    Get.back();
    log(items.toString());
  }
  //

  void removeItem(int i) {
    Get.defaultDialog(
      title: "Are you sure to Delete?",
      content: ElevatedButton(
        onPressed: () {
          items.removeAt(i);
          Get.back();
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red),
        ),
        child: const Text("Delete"),
      ),
    );
  }

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
