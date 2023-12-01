import 'package:flutter/material.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:get/get.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/lazy_network_image.dart';

class InventoryController extends GetxController {
  // List<InventoryItems> _list = [];
  RxList items = [].obs;

  // RxList<Map> inventoryData = [
  // {"name": "Apple cider", "price": 240.5, "gst": 10.0, "stock": 20, "qty": 1},
  // {"name": "BenQ Monitor", "price": 56000.0, "gst": 28.0, "stock": 211, "qty": 1},
  // {"name": "Lether belt", "price": 324.5, "gst": 18.0, "stock": 112, "qty": 1},
  // {"name": "banana shake", "price": 300.0, "gst": 15.0, "stock": 14, "qty": 1},
  // {"name": "Cup", "price": 49.0, "gst": 4.0, "stock": 121, "qty": 1},
  // {"name": "Logitec Optical Mouse", "price": 3240.0, "gst": 34.0, "stock": 184, "qty": 1},
  // {"name": "CosmicByte CB GK 03 Corona", "price": 2400.0, "gst": 22.0, "stock": 12, "qty": 1},
  // {"name": "Apple53245234", "price": 32400.0, "gst": 34.0, "stock": 1854, "qty": 1},
  // {"name": "Vinegar", "price": 32.0, "gst": 4.0, "stock": 1548, "qty": 1},
  // {"name": "Frootieeeee", "price": 24.0, "gst": 14.0, "stock": 148, "qty": 1},
  // ].obs;

  @override
  void onInit() {
    getItems();
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

  void getItems() async {
    items.value = await APIServices.getItems();
  }

  void searchItems(String searchKeyword) async {
    if (searchKeyword.trim().isEmpty) {
      getItems();
    } else {
      items.value = await APIServices.searchItems(searchKeyword);
    }
  }

  void showItemData(context, data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("more info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Item no: index", style: Theme.of(context).textTheme.headlineSmall),
            Align(
              // alignment: Align.,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NetworkImageLoader(
                    height: 150,
                    width: 150,
                    image: data["image"] ??
                        "https://mtek3d.com/wp-content/uploads/2018/01/image-placeholder-500x500.jpg",
                  )
                  // Image.network(
                  //   data["image"] ??
                  //       "https://mtek3d.com/wp-content/uploads/2018/01/image-placeholder-500x500.jpg",
                  //
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name: ${data['name']} (${data['type']})"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: ${data["description"] ?? "No description provided"}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            // Text("type: ${data['type']}"),
            Text("Category: ${data['category']}"),
            Text("Sub-Category: ${data['subCategory']}"),
            Text("Unit: ${data['unit']}"),
            Text("Batch number: ${data['batchNum']}"),
            Text("HSN: ${data['hsn']}"),
            Text("Manufacturer: ${data['manufacturer']}"),
            Text("discountPerQuantity: ${data['discountPerProduct']}"),
            Text("DiscQty: ${data['discQty']}"),
            Text("Loc: ${data['loc']}"),
            Text("Rate: ${data['rate']}"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Price: ${Utils.parseInINR(data["price"])}'),
                  Text('MRP: ${Utils.parseInINR(data["mrp"])}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} //END
