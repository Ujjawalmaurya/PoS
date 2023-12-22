import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_purchase/add_item_details.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class AddPurchase extends GetWidget<PurchaseController> {
  static const String path = '/addPurchase';
  const AddPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Purchase"),
        // centerTitle: true,
      ),
      // floatingActionButton: const FloatingActionButton.extended(
      //   onPressed: null,
      //   icon: Icon(Icons.add),
      //   label: Text("Finish"),
      //   isExtended: true,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.purchaseFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  PoSInputField(
                    controller: controller.purchaseInvoiceNumberTxtCtr,
                    validator: (_v) {
                      return _v!.trim() == '' ? "Required" : null;
                    },
                    numbersOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        // TODO: implementt invoice input other than textfield
                      },
                      icon: const Icon(Icons.qr_code),
                    ),
                    label: "Invoice No",
                    hint: "PPL-XXX-XXXX",
                  ),
                  const SizedBox(width: 15),
                  PoSInputField(
                    validator: (_v) {
                      return _v!.trim() == '' ? "Required" : null;
                    },
                    controller: controller.purchaseDateTxtCtr,
                    readOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //TODO:
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      Future _date = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2030),
                      );
                      controller.purchaseDateTxtCtr.text = Utils.formatDate(await _date ?? DateTime.now());
                    },
                    label: "Purchase Date",
                    hint: "DD-MMM-YYYY",
                  ),
                ],
              ),
              GetBuilder<PurchaseController>(
                init: PurchaseController(),
                initState: (_) {},
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: _.selectedVendor.supplierName == null
                          ? MyDottedBorderWidget(
                              child: ListTile(
                                title: Text(_.selectedVendor.supplierName ?? "Select Supplier"),
                                onTap: () => controller.openSuppliers(),
                              ),
                            )
                          : ListTile(
                              title: Text(_.selectedVendor.supplierName ?? "Select Supplier"),
                              // isThreeLine: true,
                              subtitle: Text(_.selectedVendor.businessName ?? ''),
                              trailing: IconButton(
                                icon: const Icon(Icons.disabled_by_default),
                                onPressed: () {
                                  _.unselectSupplier();
                                },
                              ),
                            ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text("${controller.items.length} item(s)",
                        style: Theme.of(context).textTheme.headlineSmall)),
                    OutlinedButton.icon(
                      label: const Text("Add more"),
                      icon: const Icon(Icons.add_circle_outline_sharp),
                      onPressed: () {
                        Get.toNamed(PurchaseItemForm.path);
                        // Get.bottomSheet(
                        // isDismissible: false,
                        // BottomSheet(
                        //   onClosing: () {},
                        //   builder: (c) => _Form(context),
                        // ),
                        // );
                      },
                      // label: const Text("Add new Item"),
                    ),
                  ],
                ),
              ),
              Card(
                child: Obx(
                  () => controller.items.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          child: Text(
                            "No items are Selected",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: controller.items.length,
                            itemBuilder: (c, i) {
                              var data = controller.items[i]["product"];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _ItemInputForm(
                                  "Item " + data['name'] + "(${data['category']})" ?? "Null Name",
                                  "MRP: " + data['mrp'] ?? "Null MRP",
                                  data['quantityMax'] ?? "Null qty",
                                  () => controller.removeItem(i),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outlined),
                onPressed: () {
                  if (controller.purchaseFormKey.currentState!.validate()) {
                    if (controller.selectedVendor.supplierName == null || controller.items.isEmpty) {
                      MassengerScaffold.notifyUser(context, "Select a vendor and item(s)");
                    } else {
                      log("Validation success");
                      controller.createPurchase();
                    }
                  } else {
                    log("Incomplete validation");
                  }
                },
                label: const Text("Complete Purchase"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ItemInputForm(String itemName, subtitle, trailing, Function() onTap) {
    return ListTile(
      title: Text(itemName),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trailing),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.remove_circle),
          ),
        ],
      ),
    );
  }
}
