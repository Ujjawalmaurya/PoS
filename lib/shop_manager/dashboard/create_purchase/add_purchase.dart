import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/shop_manager/parties/vendor_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  PoSInputField(
                    validator: (_v) {
                      return _v!.trim() == '' ? "Required" : null;
                    },
                    numbersOnly: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        // TODO: implementt ivoice input
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
                    controller: controller.dateTxtCtr,
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
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
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Select suppliers",
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ),
                                        ListView.separated(
                                          separatorBuilder: (c, i) => const Divider(color: Colors.black),
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
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add items", style: Theme.of(context).textTheme.headlineSmall),
                    IconButton(
                      icon: const Icon(Icons.plus_one_outlined),
                      onPressed: () {
                        controller.items.add({});
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                            itemCount: controller.items.length,
                            itemBuilder: (c, i) => PoSInputField(
                              validator: (_v) {
                                return _v!.trim() == '' ? "Required" : null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // TODO: Remove
                                  controller.items.remove(controller.items[i]);
                                },
                                icon: const Icon(Icons.highlight_remove),
                              ),
                              label: "Add ${i + 1} Item",
                              hint: "Name",
                              onChanged: (value) {
                                controller.items[i]['itemName'] = value;
                                log("${controller.items}");
                              },
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  if (controller.purchaseFormKey.currentState!.validate()) {
                    log("Validation success");
                  } else {
                    log("Incomplete validation");
                  }
                },
                label: const Text("Next"),
              )
            ],
          ),
        ),
      ),

      //        Padding(
      //           padding: const EdgeInsets.only(bottom: 20, top: 10),
      //           child: ElevatedButton.icon(
      //             onPressed: () {
      //               //TODO:
      //               if (controller.purchaseFormKey.currentState!.validate()) {
      //                 // Navigate the user to the Home page
      //                 showSnackbar("Validated", "All forms are filled");
      //               } else {
      //                 // notifyUser(context, 'Please fill input');
      //               }
      //             },
      //             icon: const Icon(Icons.add),
      //             label: const Text("Complete purchase"),
      //           ),
      //         )

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
      // validator: (_v){
      //
      // },
      //                   label: "Item name",
      //                   hint: "Item name",
      //                   controller: controller.itemName,
      //                 ),
      //                 PoSInputField(
      // validator: (_v){
      //
      // },
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
// validator: (_v){
//   
// },
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
// validator: (_v){
//   
// },
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


//                                    Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Align(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "Item: ${item['itemName'] ?? 'none item name'}",
//                                         softWrap: false,
//                                         style: Theme.of(context).textTheme.titleMedium,
//                                       ),
//                                     ),
//                                   ),
//                                   PoSInputField(
//                                     validator: (_v) {
//                                       return _v!.trim() == '' ? "Required" : null;
//                                     },
//                                     label: "Category",
//                                     hint: "Value",
//                                     onChanged: (_v) {
//                                       //TODO on-changed
//                                       item['category'] = _v;
//                                       log(item.toString());
//                                     },
//                                   ),
//                                   PoSInputField(
//                                     validator: (_v) {
//                                       return _v!.trim() == '' ? "Required" : null;
//                                     },
//                                     label: "sub-category",
//                                     hint: "Value",
//                                     onChanged: (_v) {
//                                       //TODO on-changed
//                                       item['subcategory'] = _v;
//                                       log(item.toString());
//                                     },
//                                   ),
//                                   Row(
//                                     children: [
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "MRP",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['mrp'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "Price",
//                                         hint: "NXT Vluence",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['price'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   PoSInputField(
//                                     validator: (_v) {
//                                       return _v!.trim() == '' ? "Required" : null;
//                                     },
//                                     label: "Expiry",
//                                     hint: "Value",
//                                     onChanged: (_v) {
//                                       //TODO on-changed
//                                       item['expiry'] = _v;
//                                       log(item.toString());
//                                     },
//                                   ),
//                                   Row(
//                                     children: [
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "CGST",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['cgst'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "SGST",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['sgst'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   PoSInputField(
//                                     validator: (_v) {
//                                       return _v!.trim() == '' ? "Required" : null;
//                                     },
//                                     label: "Manufacturer",
//                                     hint: "Value",
//                                     onChanged: (_v) {
//                                       //TODO on-changed
//                                       item['manufacturer'] = _v;
//                                       log(item.toString());
//                                     },
//                                   ),
//                                   Row(
//                                     children: [
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "CD",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['cd'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "TD",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['td'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "HSN",
//                                         hint: "HSN Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['hsn'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "Batch no",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['batch'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim() == '' ? "Required" : null;
//                                         },
//                                         label: "quantity",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['qty'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                       PoSInputField(
//                                         validator: (_v) {
//                                           return _v!.trim().isEmpty ? "Required" : null;
//                                         },
//                                         label: "pack size",
//                                         hint: "Value",
//                                         onChanged: (_v) {
//                                           //TODO on-changed
//                                           item['pack'] = _v;
//                                           log(item.toString());
//                                         },
//                                       ),
//                                     ],
//                                   ),

