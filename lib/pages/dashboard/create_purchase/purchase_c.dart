import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/parties/vendor_model.dart';
import 'package:pos/pages/parties/party_c.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/storage_keys.dart';

class PurchaseController extends GetxController {
  Vendor selectedVendor = Vendor();

  final purchaseFormKey = GlobalKey<FormState>();
  final purchaseItemsFormKey = GlobalKey<FormState>();

  // RxList<TextEditingController> txtControllers = <TextEditingController>[].obs;

  InventoryController inventoryController = Get.find<InventoryController>();
  RxList<Map> items = <Map>[].obs;

//? ===== TextEditingControllers ====

  TextEditingController purchaseDateTxtCtr = TextEditingController();
  TextEditingController purchaseInvoiceNumberTxtCtr = TextEditingController();
  // Item form field TextEditingConrollers
  TextEditingController itemNameTextCtr = TextEditingController();
  TextEditingController mrpTextCtr = TextEditingController();
  TextEditingController itemExpiryDateTxtCtr = TextEditingController();
  // TextEditingController gstTextCtr = TextEditingController();
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
    locTextCtr.clear();
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
      "hsn": hsnTextCtr.text,
      "manufacturer": manufacturerTextCtr.text,
      "unit": "string",
      "batchNum": batchTextCtr.text,
      "discQty": discountQtyTextCtr.text,
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
      "expiry": itemExpiryDateTxtCtr.text,
    });
    log(items.toString());
    // clearFormFields();
    Get.back();
    log("Total Items=> $items");
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

  void openSuppliers() => Get.bottomSheet(
        BottomSheet(
          onClosing: () {},
          builder: (context) {
            PartyController partyController = Get.find<PartyController>();
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Select suppliers",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: partyController.vendors.length,
                    separatorBuilder: (c, i) => const Divider(color: Colors.black),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Vendor _data = partyController.vendors[index];
                      return ListTile(
                        // isThreeLine: true,
                        title: Text(_data.supplierName.toString()),
                        subtitle: Text(_data.businessName.toString()),
                        onTap: () => updateSupplierSelection(_data),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );

  void createPurchase() {
    Map _body = {
      "businessDetails": {"id": readData(StorageKey.user.userData)['businessId'].toString()},
      "category": selectedCategory,
      "items": items,
      "preCreatedDate": purchaseDateTxtCtr.text,
      "preCreatedInvoice": purchaseInvoiceNumberTxtCtr.text,
      "salesMan": selectedVendor.supplierName,
      "vendor": {"id": selectedVendor.id}
    };
    var res = APIServices.createPurchase(_body);
    log(res.toString());
    // log(json.decode(res.body));
  }

// Purchase invoice payload
// {
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
