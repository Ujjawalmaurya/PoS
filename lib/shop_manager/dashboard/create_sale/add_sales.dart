import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/cart_items_tile.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/inventory_item_tile.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/slidable_widget.dart';

class AddSales extends GetWidget<AddSalesController> {
  const AddSales({super.key});

  @override
  Widget build(BuildContext context) {
    final Color greyShade = Colors.grey.shade300;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Sales"),
        // actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => controller.selectedCustomer.isEmpty
                          ? MyDottedBorderWidget(
                              child: ListTile(
                                // tileColor: greyShade,
                                title: const Text("Select customer"),
                                onTap: () => Get.toNamed('/showCustomersForSale'),
                              ),
                            )
                          : ListTile(
                              // trailing: OutlinedButton.icon(
                              //   onPressed: () {},
                              //   icon: const Icon(Icons.person),
                              //   label: const Text("Change customer"),
                              // ),
                              tileColor: greyShade,
                              subtitle: const Text("Tap to change Customer"),
                              onTap: () => Get.toNamed('/showCustomersForSale'),
                              title: Text("Customer: ${controller.selectedCustomer["name"]}"),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => controller.selectedItems.isEmpty
                          ? MyDottedBorderWidget(
                              child: ListTile(
                                title: const Text("Select Items"),
                                onTap: () => Get.toNamed('/showItemsToSale'),
                              ),
                            )
                          : ExpansionTile(
                              backgroundColor: Colors.grey.shade300,
                              // trailing: IconButton(
                              //   onPressed: () => Get.toNamed('/showItemsToSale'),
                              //   icon: const Icon(Icons.add),
                              // ),
                              subtitle:
                                  Obx(() => Text("Total is ${Utils.parseInINR(controller.subTotal.value)}")),
                              initiallyExpanded: true,
                              title: Text(
                                "${controller.selectedItems.length} Items are selected",
                              ),
                              trailing: OutlinedButton.icon(
                                onPressed: () => Get.toNamed('/showItemsToSale'),
                                icon: const Icon(Icons.add),
                                label: const Text("Add more"),
                              ),
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.selectedItems.length,
                                  itemBuilder: (context, index) {
                                    InvoiceItem _item = controller.selectedItems[index];
                                    return SlidableWidget(
                                      onDismissed: () {
                                        controller.removeFromSelectedItems(_item);
                                      },
                                      child: CartItemTile(
                                        mrp: 5.0,
                                        name: _item.itemName,
                                        price: _item.unitPrice,

                                        // tileColor: Colors.greenAccent,

                                        // title: Text(_item.itemName),
                                        // trailing: Text(Utils.parseInINR(_item.unitPrice)),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                  Obx(
                    () => controller.totalAmount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                            child: SizedBox(
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Sub total: ${Utils.parseInINR(controller.subTotal.value)} Rs",
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.increaseDiscount(),
                                    child: Text(
                                      "Discount: - ${Utils.parseInINR(controller.discount.value)} Rs",
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Net Total: ${Utils.parseInINR(controller.totalAmount.value)}',
                                      style: Theme.of(context).textTheme.headlineSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => ElevatedButton.icon(
              icon: const Icon(Icons.done),
              onPressed: () {
                controller.selectedItems.isEmpty || controller.selectedCustomer.isEmpty
                    ? {
                        showSnackbar(
                          "Incomplete Task",
                          "Items or Customers are not selected properly",
                        )
                      }
                    : {
                        // ! PROCEEED
                        controller.writeInvoice(
                            // controller.selectedItems,
                            // controller.constCustomer,
                            // controller.constSupplier,
                            )
                      };
              },
              label: Text(
                controller.selectedItems.isEmpty || controller.selectedCustomer.isEmpty
                    ? "Please select Items and customer"
                    : "Generate invoice from selected items",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
