import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/parties/vendor_model.dart';
import 'package:pos/pages/parties/party_c.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class AddInventoryController extends GetxController {
  final addItemFormKey = GlobalKey<FormState>();

  PartyController partyController = Get.find<PartyController>();
  Vendor selectedVendor = Vendor();

  // ! TXT-Ctrl
  TextEditingController itemNameCtr = TextEditingController();
  TextEditingController itemExpCtr = TextEditingController();
  TextEditingController manufacturerCtr = TextEditingController();
  TextEditingController hsnCtr = TextEditingController();
  TextEditingController batchCtr = TextEditingController();
  TextEditingController packSizeCtr = TextEditingController();
  TextEditingController mrpCtr = TextEditingController();
  TextEditingController rateCtr = TextEditingController();
  TextEditingController purchasePriceCtr = TextEditingController();
  TextEditingController openingStocksCtr = TextEditingController();
  TextEditingController qtyCtr = TextEditingController();
  TextEditingController discountCtr = TextEditingController();
  TextEditingController discountQtyCtr = TextEditingController();
  TextEditingController tdCtr = TextEditingController();
  TextEditingController cdCtr = TextEditingController();
  TextEditingController cgstCtr = TextEditingController();
  TextEditingController sgstCtr = TextEditingController();
  // TextEditingController Ctr = TextEditingController();

  RxBool isTaxable = false.obs;

  // ! Image Picker
  final ImagePicker picker = ImagePicker();

  RxString defaultCategory = ''.obs;
  RxString selectedCategory = ''.obs;

  RxString defaultSubCategory = ''.obs;
  RxString selectedSubCategory = ''.obs;

  List<Vendor> vendorList = [];

  @override
  void onInit() {
    vendorList = partyController.vendors;
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

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

  XFile? itemImage;

  void addItem() {
    final res = APIServices.addItem({
      // "id": 3,
      "name": itemNameCtr.text,
      "batchNum": batchCtr.text,
      "category": selectedCategory.value,
      "subCategory": selectedSubCategory.value,
      "manufacturer": manufacturerCtr.text,
      "vendorId": selectedVendor.id,
      "cd": cdCtr.text,
      "td": tdCtr.text,
      "cgst": cgstCtr.text,
      "sgst": sgstCtr.text,
      "discQty": discountQtyCtr.text,
      "discountPerProduct": discountCtr.text,
      "hsn": int.parse(hsnCtr.text),
      "loc": "LOC",
      "mrp": mrpCtr.text,
      "quantityChild": 0,
      "quantityMax": 0,
      "quantityParent": 0,
      "rate": rateCtr.text,
      "totalAmount": 5400,
      "type": "TABLET",
      "unit": "string",
      "expiry": itemExpCtr.text,
    }).then((value) => {
          Get.find<InventoryController>().getItems(),
          // log("RESS ====================> \n${json.decode(value.body)}\n ====================="),
        });
  }

  pickImage(context) async {
    XFile? photo;
// Capture a photo.
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Select source",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 40,
                        onPressed: () async {
                          photo = await picker.pickImage(source: ImageSource.camera);
                          itemImage = photo;
                          update();
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                      const Text("Pick from Camera"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 40,
                        onPressed: () async {
                          photo = await picker.pickImage(source: ImageSource.gallery);
                          itemImage = photo;
                          update();
                        },
                        icon: const Icon(Icons.file_copy),
                      ),
                      const Text("Pick from gallery"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  }
} // END