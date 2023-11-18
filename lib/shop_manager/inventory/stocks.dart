// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/inventory/inventory_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/inventory_item_tile.dart';
import 'package:pos/src/widgets/search_field.dart';

class Stocks extends GetWidget<InventoryController> {
  static const path = '/stocks';
  const Stocks({super.key});

  void _onTap(context, data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("more info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("Item no: index", style: Theme.of(context).textTheme.headlineSmall),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                data["image"] ??
                    "https://mtek3d.com/wp-content/uploads/2018/01/image-placeholder-500x500.jpg",
                height: 150,
                width: 150,
                fit: BoxFit.cover,
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

  @override
  Widget build(BuildContext context) {
    // final _i = ref.watch(inventoryItemsProvider);
    // final _t = ref.watch(testValues);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text("Inventory"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addInventory'),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            const SearchField(),
            Flexible(
              child: controller.items.isEmpty
                  ? Center(child: Text("No items \n ${controller.items}"))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.items.length,
                      // itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var _data = controller.items[index];
                        return InventoryItemTile(
                          type: _data["type"],
                          category: _data['category'],
                          subCategory: _data['subCategory'],
                          price: _data['mrp'],
                          name: _data['name'],
                          sellingPrice: 52.1,
                          stock: _data['quantityMax'],
                          purchasingPrice: 58.14,
                          ontap: () => _onTap(context, _data),
                        );
                      },
                    ),
              // : ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: controller.items.length,
              //     // itemCount: 5,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       var _data = controller.items[index];
              //       return InventoryItemTile(
              //           stock: _data.stock,
              //           imageURL: _data.thumbnail,
              //           description: _data.description,
              //           price: _data.price * 85,
              //           name: _data.title,
              //           sellingPrice: _data.price * 85.0,
              //           purchasingPrice: _data.price * 83.0,
              //           ontap: () => _onTap(context, _data));
              //     },
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}
