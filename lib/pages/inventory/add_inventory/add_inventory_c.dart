import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/parties/vendor_model.dart';
import 'package:pos/pages/parties/party_c.dart';
import 'package:pos/src/services/apiServices.dart';

class AddInventoryController extends GetxController {
  final addItemFormKey = GlobalKey<FormState>();

  PartyController partyController = Get.find<PartyController>();
  Vendor selectedVendor = Vendor();

  // ! TXT-Ctrl
  TextEditingController itemNameCtr = TextEditingController();
  TextEditingController itemExpCtr = TextEditingController();
  TextEditingController manufacturerCtr = TextEditingController();
  TextEditingController hsnCtr = TextEditingController();
  TextEditingController locCtr = TextEditingController();
  TextEditingController batchCtr = TextEditingController();
  TextEditingController packSizeCtr = TextEditingController();
  TextEditingController mrpCtr = TextEditingController();
  TextEditingController rateCtr = TextEditingController();
  // TextEditingController purchasePriceCtr = TextEditingController();
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

  // final List<String> categories = [
  // 'Food and Beverages ',
  // "Personal Care and Hygiene",
  // "Household Cleaning and Care",
  // "Health and Wellness",
  // "Baby and Childcare",
  // "Confectionery and Chocolates",
  // "Beauty and Cosmetics",
  // "Pharmaceuticals",
  // "Tobacco and Cigarettes",
  //   "General",
  //   "Pharma"
  // ];
//   final List<String> subCategories = [
// // Food and Beverages
//     "Packaged Food Items",
//     "Snacks",
//     "Soft Drink",
//     "Juices",
//     'Dairy',
// // Personal Care and Hygiene
//     "Toiletries",
//     "Haircare",
//     "Skincare",
//     'Oral care',
// // Household Cleaning and Care
//     "Laundry Detergents",
//     "Air Fresheners",
//     "Cleaning Agents",
//     'Disinfectants',
// // Health and Wellness
//     "Over-the-Counter Medicines",
//     "Vitamins & Supplements",
//     "Health Drinks",
// // Baby and Childcare
//     "Diapers",
//     "Baby Food",
//     "Baby Wipes",
//     "Baby Skincare Products",
// // Confectionery and Chocolates
//     "Chocolates",
//     "Candies and Sweets",
//     "Gums and Chewing Products",

// // Beuty and cosmetics
//     "Makeup",
//     "Perfume",
//     "Hair Styling Products",
// // tobacco and cigarettes
//     "Cigarettes",
//     "Chewing Tobacco",
// // Pharmaceutical
//     "Prescription Medicine",
//     "Pain Relief",
//     "Respiratory & Allergies",
//     "Eye & Ear Care",
//     "Foot & Leg Care",
//     "Oral Care",
//     "Digestive Care",
//     "Skin & Scalp Care",
//     "Health Supplements",
//     "Natural & Homoeopathic",
//     "Personal Aids & Repellents",
//     "Sleep & Stress Relief",
//     "Family Planning",
//     "First Aid",
//     "Baby Treatments",
//     "Medical Devices",
  // ];
  XFile? itemImage;

  void addItem() async {
    var res = await APIServices.addItem({
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
      "loc": locCtr.text,
      "mrp": double.parse(mrpCtr.text),
      "type": "TABLET",
      "unit": "string",
      "quantityChild": 0,
      "quantityMax": 0,
      "quantityParent": qtyCtr.text,
      "rate": double.parse(rateCtr.text),
      "totalAmount": double.parse(mrpCtr.text) * double.parse(qtyCtr.text),
      "expiry": itemExpCtr.text,
    }).then((value) => {
          Get.find<InventoryController>().getItems(),
          // log("RESS ====================> \n${json.decode(value.body)}\n ====================="),
        });

    // final _data = json.decode(res.body);
    // log(_data.toString());

    // if (res.statusCode == 201) {
    //   Snackbar.success("Success", "${itemNameCtr.text} added successfully");
    //   addItemFormKey.currentState!.reset();
    // } else {
    //   Snackbar.failed("Failed", "Error while adding ${itemNameCtr.text} in inventory");
    // }
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
