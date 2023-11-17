import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/shop_manager/parties/add_party/vendor_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class AddPurchase extends GetWidget<PurchaseController> {
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              PoSInputField(
                numbersOnly: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code),
                ),
                label: "Invoice No",
                hint: "PPL-XXX-XXXX",
              ),
              const SizedBox(width: 15),
              PoSInputField(
                controller: controller.dateTxtCtr,
                readOnly: true,
                onTap: () async {
                  Future _date = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2030),
                  );
                  controller.dateTxtCtr.text = Utils.formatDate(await _date);
                },
                label: "Date",
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
                child: MyDottedBorderWidget(
                  child: ListTile(
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
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: MyDottedBorderWidget(
              child: ExpansionTile(
                initiallyExpanded: true,
                // onTap: () => Get.toNamed('/showItemsToPurchase'),
                // onTap: () => {},
                // selected: true,
                title: const Text("Select items"),
                trailing: OutlinedButton.icon(
                  onPressed: () {},
                  // onPressed: () => Get.toNamed('/addInventory'),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Items"),
                ),
                children: const [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
          ),
        ],
      ),
      // Obx(
      //   () => Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       controller.index.value == 0
      //           ? Expanded(
      //               child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 PoSInputField(
      //                   label: "Item name",
      //                   hint: "Item name",
      //                   controller: controller.itemName,
      //                 ),
      //                 PoSInputField(
      //                   label: 'Price',
      //                   hint: "MRP in INR",
      //                   controller: controller.mrp,
      //                 ),
      //                 const Text("Item Exp"),
      //               ],
      //             ))
      //           : const SizedBox.shrink(),
      //       controller.index.value == 1
      //           ? Expanded(
      //               child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Text(
      //                   "Item: " + "${controller.itemName.text}",
      //                   style: Theme.of(context).textTheme.titleMedium,
      //                 ),
      //                 const Text("Item Exp page 2"),
      //               ],
      //             ))
      //           : const SizedBox.shrink(),
      //       controller.index.value == 2
      //           ? const Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Text("Item Exp page 3"),
      //                 ],
      //               ),
      //             )
      //           : const SizedBox.shrink(),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Align(
      //           alignment: Alignment.bottomRight,
      //           child: controller.index <= controller.maxIndex
      //               ? Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     ElevatedButton.icon(
      //                       onPressed: () {
      //                         if (controller.index >= 1) {
      //                           controller.index.value--;
      //                         }
      //                       },
      //                       icon: const Icon(Icons.skip_previous),
      //                       label: const Text("Back"),
      //                     ),
      //                     ElevatedButton.icon(
      //                       onPressed: () {
      //                         controller.index.value++;
      //                         log(controller.index.value.toString());
      //                       },
      //                       icon: const Icon(Icons.skip_next),
      //                       label: const Text("Next"),
      //                     ),
      //                   ],
      //                 )
      //               : ElevatedButton(
      //                   onPressed: () {},
      //                   child: const Text("Finish"),
      //                 ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}


      // Column(
      //   children: [
      //     const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          // PoSInputField(
          //   numbersOnly: true,
          //   suffixIcon: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.qr_code),
          //   ),
          //   label: "Invoice No",
          //   hint: "PPL-XXX-XXXX",
          // ),
          // const SizedBox(width: 15),
          // PoSInputField(
          //   controller: controller.dateTxtCtr,
          //   readOnly: true,
          //   onTap: () async {
          //     Future _date = showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime(2010),
          //       lastDate: DateTime(2030),
          //     );
          //     controller.dateTxtCtr.text = Utils.formatDate(await _date);
          //   },
          //   label: "Date",
          //   hint: "DD-MMM-YYYY",
          // ),
          //   ],
          // ),
          //     GetBuilder<PurchaseController>(
          //       init: PurchaseController(),
          //       initState: (_) {},
          //       builder: (_) {
          //         return Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: MyDottedBorderWidget(
          //             child: ListTile(
          //               title: Text(_.selectedVendor.supplierName ?? "Select Supplier"),
          //               // isThreeLine: true,
          //               subtitle: Text(_.selectedVendor.businessName ?? ''),
          //               onTap: () {
          //                 Get.bottomSheet(
          //                   BottomSheet(
          //                     onClosing: () {},
          //                     builder: (context) {
          //                       PartyController partyController = Get.find<PartyController>();
          //                       return SingleChildScrollView(
          //                         physics: const AlwaysScrollableScrollPhysics(),
          //                         child: Column(
          //                           children: [
          //                             Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Text(
          //                                 "Select suppliers",
          //                                 style: Theme.of(context).textTheme.titleLarge,
          //                               ),
          //                             ),
          //                             ListView.builder(
          //                               physics: const NeverScrollableScrollPhysics(),
          //                               shrinkWrap: true,
          //                               itemCount: partyController.vendors.length,
          //                               itemBuilder: (context, index) {
          //                                 Vendor _data = partyController.vendors[index];
          //                                 return ListTile(
          //                                   // isThreeLine: true,
          //                                   title: Text(_data.supplierName.toString()),
          //                                   subtitle: Text(_data.businessName.toString()),
          //                                   onTap: () {
          //                                     _.updateSupplierSelection(_data);
          //                                     log("${controller.selectedVendor.supplierName} Selected");
          //                                   },
          //                                 );
          //                               },
          //                             ),
          //                           ],
          //                         ),
          //                       );
          //                     },
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8),
          //       child: MyDottedBorderWidget(
          //         child: ListTile(
          //           onTap: () => Get.toNamed('/showItemsToPurchase'),
          //           // selected: true,
          //           title: const Text("Select items"),
          //           trailing: OutlinedButton.icon(
          //             onPressed: () => Get.toNamed('/addInventory'),
          //             icon: const Icon(Icons.add),
          //             label: const Text("Add a new Item"),
          //           ),
          //         ),
          //       ),
          //     ),
      //   ],
      // ),