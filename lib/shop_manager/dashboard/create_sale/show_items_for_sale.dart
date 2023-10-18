import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';
import 'package:pos/src/utils/utils.dart';

class ShowItemsForSale extends GetWidget<AddSalesController> {
  const ShowItemsForSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.back(),
        icon: const Icon(Icons.check),
        label: Obx(
          () => Text(
            'Proceed with ${controller.selectedItems.length} Item(s)',
          ),
        ),
      ),
      appBar: AppBar(
        title: Obx(
          () => Text(
            "Select items (Total:${Utils.parseInINR(controller.totalAmount.value)})",
          ),
        ),
        // actions: [
        //   Obx(() => (controller.selectedItems.isNotEmpty)
        //       ? Text('${controller.selectedItems.length} Items Selected')
        //       : const Text("Select items"))
        // ],
      ),
      body: Column(
        children: [
          SearchBar(
            // backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
            controller: controller.searchController,
            leading: const Icon(Icons.search_rounded),
            hintText: "Search",
            onChanged: (value) => {log("Search => $value")},
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: false,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: controller.inventoryData.length,
              itemBuilder: (context, index) {
                var _data = controller.inventoryData[index];
                var item = InvoiceItem(
                  itemName: _data['name'],
                  quantity: _data['qty'],
                  gst: _data['gst'],
                  unitPrice: _data['price'],
                  expiryDate: DateTime(2030),
                );
                return ListTile(
                  // tileColor: ,
                  // onTap: () => controller.selectedItems.add(item),
                  onTap: () => controller.addToSelectedItems(item),
                  title: Text(_data['name']),
                  subtitle: Text("GST ${_data['gst']}%"),
                  trailing: Text("Price: ${_data['price']} Rs"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
