import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_sale/sales_c.dart';
import 'package:pos/src/widgets/search_field.dart';

class ShowItemsForSale extends GetWidget<AddSalesController> {
  static const String path = '/showItemsToSale';
  const ShowItemsForSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.check),
        tooltip: "Proceed to buy",
        label: Obx(
          () => Text(
            'Proceed with ${controller.selectedItems.length} Item(s)',
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          // "Select items (Total:${Utils.parseInINR(controller.totalAmount.value)})",
          "Select items",
        ),
        // actions: [
        //   Obx(() => (controller.selectedItems.isNotEmpty)
        //       ? Text('${controller.selectedItems.length} Items Selected')
        //       : const Text("Select items"))
        // ],
      ),
      body: Column(
        children: [
          SearchField(
            // backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
            // controller: controller.searchController,
            // leading: const Icon(Icons.search_rounded),
            hint: "Search(i.e., item name, sub category, manufacturer, batch number)",
            onChanged: (keyword) => controller.inventoryController.searchItems(keyword),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                shrinkWrap: false,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.inventoryController.items.length,
                itemBuilder: (context, index) {
                  var _data = controller.inventoryController.items[index];
                  log("_Data: ");
                  // var item = InvoiceItem(
                  //   itemName: _data['name'],
                  //   quantity: _data['qty'],
                  //   gst: _data['gst'],
                  //   unitPrice: _data['price'],
                  //   expiryDate: DateTime(2030),
                  // );
                  return ListTile(
                    // onTap: () => controller.addToSelectedItems(_data),
                    title: Text("${_data['name']}"),
                    // subtitle: Text("GST ${_data['gst']}%"),
                    subtitle: Text(
                      "Price: ${_data['mrp']} Rs\n(${_data['stock']} items available in stock)",
                    ),
                    trailing: InkWell(
                      onTap: () => controller.addToSelectedItems(_data),
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
