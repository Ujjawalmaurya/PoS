import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/shop_manager/parties/add_party/vendor_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';

class AddPurchase extends GetWidget<PurchaseController> {
  const AddPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Purchase"),
        // centerTitle: true,
      ),
      floatingActionButton: const FloatingActionButton.extended(
        onPressed: null,
        icon: Icon(Icons.add),
        label: Text("Finish"),
        isExtended: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          GetBuilder<PurchaseController>(
            init: PurchaseController(),
            initState: (_) {},
            builder: (_) {
              return ListTile(
                title: Text(_.selectedVendor.supplierName ?? "Select Supplier"),
                // isThreeLine: true,
                subtitle: Text(_.selectedVendor.businessName ?? ''),
                onTap: () {
                  Get.bottomSheet(
                    BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        PartyController partyController = Get.find<PartyController>();
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Select suppliers",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: partyController.vendors.length,
                                itemBuilder: (context, index) {
                                  Vendor _data = partyController.vendors[index];
                                  return ListTile(
                                    // isThreeLine: true,
                                    title: Text(_data.supplierName.toString()),
                                    subtitle: Text(_data.businessName.toString()),
                                    onTap: () {
                                      _.updateSupplierSelection(_data);
                                      log("${controller.selectedVendor.supplierName} Selected");
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            onTap: () => Get.toNamed('/showItemsToPurchase'),
            // selected: true,
            title: const Text("Select items"),
            trailing: OutlinedButton.icon(
              onPressed: () => Get.toNamed('/addInventory'),
              icon: const Icon(Icons.add),
              label: const Text("Add a new Item"),
            ),
          ),
        ],
      ),
    );
  }
}
