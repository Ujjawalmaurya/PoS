import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/shop_manager/dashboard/create_sale/payment_mode.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';
import 'package:pos/shop_manager/parties/customer_model.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/cart_items_tile.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/slidable_widget.dart';

class AddSales extends GetWidget<AddSalesController> {
  const AddSales({super.key});

  @override
  Widget build(BuildContext context) {
    log(controller.selectedCustomer.value!.name.toString());
    final Color greyShade = Colors.grey.shade300;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Sales"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () => controller.isLandscape.value = !controller.isLandscape.value,
              icon: controller.isLandscape.value ? const Icon(Icons.landscape) : const Icon(Icons.portrait),
            ),
          )
        ],
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
                      () => controller.selectedCustomer.value!.name == null
                          ? MyDottedBorderWidget(
                              child: ListTile(
                                title: const Text("Select customer"),
                                onTap: () => Get.toNamed('/showCustomersForSale'),
                              ),
                            )
                          : ListTile(
                              selected: true,
                              // dense: true,
                              selectedTileColor: greyShade,
                              // isThreeLine: true,
                              subtitle: Text("Tap to change Customer",
                                  style: Theme.of(context).textTheme.bodySmall),
                              onTap: () => Get.toNamed('/showCustomersForSale'),
                              title: Text(
                                  "Customer: ${controller.selectedCustomer.value!.name}\n(+91-${controller.selectedCustomer.value!.contact})"),
                              trailing: IconButton(
                                onPressed: () => controller.selectedCustomer.value = Customer(),
                                icon: const Icon(Icons.cancel),
                              ),
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
                                        onIncrease: () => controller.increaseQuantity(index),
                                        onDecrease: () => controller.decreaseQuantity(index),
                                        mrp: 5.0,
                                        quantity: _item.quantity,
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Discount:  In %'),
                                            Obx(
                                              () => Switch(
                                                value: controller.finalDiscountType_isValue.value,
                                                onChanged: (value) {
                                                  controller.finalDiscountType_isValue.value = value;
                                                },
                                              ),
                                            ),
                                            Text('in Amount (Rs)'),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () => controller.updateDiscount(),
                                          child: Obx(() => Text(
                                                "- ${Utils.parseInINR(controller.discount.value)} ${controller.finalDiscountType_isValue.value ? "Rs" : "%"}",
                                                textAlign: TextAlign.end,
                                                style: Theme.of(context).textTheme.titleMedium,
                                              )),
                                        ),
                                      ],
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
                  ),
                  Obx(
                    () => ListTile(
                      // onTap: () => Get.to(const PaymentMode()),
                      onTap: () => Get.defaultDialog(
                        title: "Select a payment Method:",
                        contentPadding: const EdgeInsets.all(10),
                        titlePadding: const EdgeInsets.all(10),
                        content: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  controller.payType.value = PaymentType.card;
                                  Get.back();
                                },
                                icon: const Icon(Icons.credit_card),
                                label: const Text("Credit/Debit Card"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  controller.payType.value = PaymentType.cash;
                                  Get.back();
                                },
                                icon: const Icon(Icons.currency_rupee_rounded),
                                label: const Text("Cash"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  controller.payType.value = PaymentType.upi;
                                  Get.back();
                                },
                                icon: const Icon(Icons.system_update_outlined),
                                label: const Text("UPI"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text("Payment Mode -  Selected ${controller.payType.value}"),
                      // subtitle: Text("Selected Payment Type ${controller.payType.value}"),
                    ),
                  ),
                  // DropdownButton(items: DropdownMenuItem['',''], onChanged: (_val){})
                ],
              ),
            ),
          ),
          Obx(
            () => ElevatedButton.icon(
              icon: const Icon(Icons.done),
              onPressed: () {
                controller.selectedItems.isEmpty ||
                        controller.selectedCustomer.value!.name.toString().trim() == ''
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
                controller.selectedItems.isEmpty ||
                        controller.selectedCustomer.value!.name.toString().trim() == ''
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
