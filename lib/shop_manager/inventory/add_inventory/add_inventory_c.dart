import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class AddInventoryController extends GetxController {
  final addItemFormKey = GlobalKey<FormState>();

  bool isTaxable = false;

  // ! Image Picker
  final ImagePicker picker = ImagePicker();

  RxString defaultCategory = ''.obs;
  RxString selectedCategory = ''.obs;

  RxString defaultSubCategory = ''.obs;
  RxString selectedSubCategory = ''.obs;

  final List<String> categories = [
    'Food and Beverages ',
    "Personal Care and Hygiene",
    "Household Cleaning and Care",
    "Health and Wellness",
    "Baby and Childcare",
    "Confectionery and Chocolates",
    "Beauty and Cosmetics",
    "Pharmaceuticals",
    "Tobacco and Cigarettes",
  ];
  final List<String> subCategories = [
    'subcategory1',
    'subcategory2',
  ];

  XFile? itemImage;

// ! TXT-Ctrl
  // TextEditingController itemNameCtr = TextEditingController();

  void addItem() {
    showSnackbar("Adding Item", "API");
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