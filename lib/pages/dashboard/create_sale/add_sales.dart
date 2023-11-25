import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_sale/sales_c.dart';
import 'package:pos/pages/dashboard/create_sale/show_customers.dart';
import 'package:pos/pages/dashboard/create_sale/show_items_for_sale.dart';
import 'package:pos/pages/dashboard/drawer/invoice_settings.dart';
import 'package:pos/pages/parties/customer_model.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/cart_items_tile.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/slidable_widget.dart';

class AddSales extends GetWidget<AddSalesController> {
  static const String path = '/addSales';
  const AddSales({super.key});

  @override
  Widget build(BuildContext context) {
    log("Selected Customer ${controller.selectedCustomer.value!.name}");
    final Color greyShade = Colors.grey.shade300;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Sales"),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(InvoiceSettings.path),
            icon: const Icon(Icons.settings),
          ),
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
                    child: Card(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                      child: Obx(
                        () => controller.selectedCustomer.value!.name == null
                            ? MyDottedBorderWidget(
                                child: ListTile(
                                  title: const Text("Select customer"),
                                  onTap: () => Get.toNamed(ShowCustomersForSale.path),
                                ),
                              )
                            : ListTile(
                                selected: true,
                                // dense: true,
                                selectedTileColor: greyShade,
                                // isThreeLine: true,
                                subtitle: Text("Tap to change Customer",
                                    style: Theme.of(context).textTheme.bodySmall),
                                onTap: () => Get.toNamed(ShowCustomersForSale.path),
                                title: Text(
                                    "Customer: ${controller.selectedCustomer.value!.name}\n(+91-${controller.selectedCustomer.value!.contact})"),
                                trailing: IconButton(
                                  onPressed: () => controller.selectedCustomer.value = Customer(),
                                  icon: const Icon(Icons.cancel),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                      child: Obx(
                        () => controller.selectedItems.isEmpty
                            ? MyDottedBorderWidget(
                                child: ListTile(
                                  title: const Text("Select Items"),
                                  onTap: () => Get.toNamed(ShowItemsForSale.path),
                                ),
                              )
                            : ExpansionTile(
                                backgroundColor: Colors.grey.shade300,
                                // trailing: IconButton(
                                //   onPressed: () => Get.toNamed('/showItemsToSale'),
                                //   icon: const Icon(Icons.add),
                                // ),
                                subtitle: Obx(
                                    () => Text("Total is ${Utils.parseInINR(controller.subTotal.value)}")),
                                initiallyExpanded: true,
                                title: Text(
                                  "${controller.selectedItems.length} Items are selected",
                                ),
                                trailing: OutlinedButton.icon(
                                  onPressed: () => Get.toNamed(ShowItemsForSale.path),
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add more"),
                                ),
                                children: [
                                  GetBuilder<AddSalesController>(
                                    init: AddSalesController(),
                                    initState: (_) {},
                                    builder: (_) {
                                      return ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _.selectedItems.length,
                                        itemBuilder: (context, index) {
                                          Map _item = _.selectedItems[index];
                                          return SlidableWidget(
                                            onDismissed: () => _.removeFromSelectedItems(_item),
                                            child: CartItemTile(
                                              onIncrease: () => _.increaseQuantity(index),
                                              onDecrease: () => _.decreaseQuantity(index),
                                              mrp: 5.0,
                                              quantity: _item['qty'] ?? 00,
                                              name: _item['name'] ?? "Null name",
                                              price: _item['mrp'] ?? "Rs.0",

                                              // title: Text(_item.itemName),
                                              // trailing: Text(Utils.parseInINR(_item.unitPrice)),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.totalAmount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Divider(),
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
                                        // Row(
                                        //   children: [
                                        //     const Text('%'),
                                        //     Obx(
                                        //       () => Switch(
                                        //         value: controller.finalDiscountType_isValue.value,
                                        //         onChanged: (value) {
                                        //           controller.finalDiscountType_isValue.value = value;
                                        //         },
                                        //       ),
                                        //     ),
                                        //     const Text('Rs'),
                                        //   ],
                                        // ),
                                        const SizedBox.shrink(),
                                        Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.zero)),
                                          child: GestureDetector(
                                            onTap: () => controller.updateDiscount(),
                                            child: Obx(() => MyDottedBorderWidget(
                                                  child: Text(
                                                    "Discount: - ${Utils.parseInINR(controller.discount.value)} ${controller.finalDiscountType_isValue.value ? "Rs" : "%"}",
                                                    textAlign: TextAlign.end,
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Net Total: ${Utils.parseInINR(controller.totalAmount.value)}',
                                      style: Theme.of(context).textTheme.headlineSmall,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => Card(
                      child: ListTile(
                        selectedTileColor: Colors.grey.shade300,
                        selected: true,
                        leading: Icon(
                          controller.payType.value == PaymentType.card
                              ? Icons.credit_card
                              : Icons.currency_exchange_sharp,
                        ),
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
                        // title: Text("Payment Mode -  Selected ${controller.payType.value}"),
                        title: Text("${controller.payType.value}"),
                        // subtitle: Text("Selected Payment Type ${controller.payType.value}"),
                      ),
                    ),
                  ),
                  // DropdownButton(items: DropdownMenuItem['',''], onChanged: (_val){})
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ElevatedButton.icon(
                icon: const Icon(Icons.done),
                onPressed: () {
                  controller.selectedItems.isEmpty || controller.selectedCustomer.value!.name == null
                      ? {
                          // showSnackbar(
                          //   "Incomplete selection",
                          //   "Items or Customers are not selected properly",
                          // )
                          notifyUser(context, "ITEMS and CUSTOMER must be selected")
                        }
                      : {
                          // ! PROCEEED
                          // controller.writeInvoice(
                          // controller.selectedItems,
                          // controller.constCustomer,
                          // controller.constSupplier,
                          // )
                          controller.convertToInvoiceItems(),
                        };
                },
                label: Text(
                  controller.selectedItems.isEmpty || controller.selectedCustomer.value!.name == null
                      ? "Please SELECT Items and Customer"
                      : "Generate invoice",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
