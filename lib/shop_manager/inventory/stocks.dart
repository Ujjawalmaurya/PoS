// import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/inventory/inventory_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/inventory_item_tile.dart';
import 'package:pos/src/widgets/search_field.dart';

class Stocks extends GetWidget<InventoryController> {
  const Stocks({super.key});

  void _onTap(context, data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("more info"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Item no: index", style: Theme.of(context).textTheme.headlineSmall),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                data.thumbnail,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Name: ${data.title}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: ${data.description ?? "No description provided"}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price: ${Utils.parseInINR(data.price * 83)}'),
                  Text('MRP: ${Utils.parseInINR(data.price * 85)}'),
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
            SearchField(),
            Flexible(
              child: controller.items.isEmpty
                  ? Center(child: Text("Nothing to Show"))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.items.length,
                      // itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var _data = controller.items[index];
                        return InventoryItemTile(
                            stock: _data.stock,
                            imageURL: _data.thumbnail,
                            description: _data.description,
                            price: _data.price * 85,
                            name: _data.title,
                            sellingPrice: _data.price * 85.0,
                            purchasingPrice: _data.price * 83.0,
                            ontap: () => _onTap(context, _data));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
