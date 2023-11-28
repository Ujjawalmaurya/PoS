import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_purchase/add_item_details.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/pages/parties/vendor_model.dart';
import 'package:pos/pages/parties/party_c.dart';
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
                    controller: controller.expDateTxtCtr,
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
                      controller.expDateTxtCtr.text = Utils.formatDate(await _date);
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
                      child: _.selectedVendor.supplierName == null
                          ? MyDottedBorderWidget(
                              child: ListTile(
                                title: Text(_.selectedVendor.supplierName ?? "Select Supplier"),
                                // isThreeLine: true,
                                // subtitle: Text(_.selectedVendor.businessName ?? ''),
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
                                                shrinkWrap: true,
                                                itemCount: partyController.vendors.length,
                                                separatorBuilder: (c, i) =>
                                                    const Divider(color: Colors.black),
                                                physics: const NeverScrollableScrollPhysics(),
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
                        Get.bottomSheet(
                          isDismissible: false,
                          // persistent: true,
                          BottomSheet(
                            onClosing: () {},
                            builder: (c) => _Form(context),
                          ),
                        );
                        // controller.items.add({});
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
                              var data = controller.items[i];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _ItemInputForm(
                                  data['itemName'] ?? "Null Name",
                                  data['mrp'] ?? "Null MRP",
                                  data['qty'] ?? "Null qty",
                                  () => Get.defaultDialog(
                                    title: "Are you sure to Delete?",
                                    content: ElevatedButton(
                                      onPressed: () {
                                        controller.items.removeAt(i);
                                        Get.back();
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                                      ),
                                      child: const Text("Delete"),
                                    ),
                                  ),
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
                    if (controller.selectedVendor.supplierName == null && controller.items.isNotEmpty) {
                      MassengerScaffold.notifyUser(context, "Select a vendor");
                    } else {
                      log("Validation success");
                      // Get.toNamed(PutItemDetails.path);
                    }
                  } else {
                    log("Incomplete validation");
                  }
                },
                label: const Text("Complete"),
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

  Widget _Form(BuildContext context) {
    // {
    //   'itemName': '',
    //   'mrp': '',
    //   'rate': '',
    //   'qty': '',
    //   'category': '',
    //   'subcategory': '',
    //   'discount': '',
    //   'discountQTY': '',
    //   'cd': '',
    //   'td': '',
    //   'cgst': '',
    //   'sgst': '',
    //   'expiry': '',
    //   'hsn': '',
    //   'batch': '',
    //   'packSize': '',
    //   'manufacturer': '',
    // }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: controller.purchaseItemsFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Add Items",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            PoSInputField(
              controller: controller.itemNameTextCtr,
              label: "Name",
              hint: "Item Name",
              onChanged: (name) {
                controller.singleItemData['itemName'] = name;
              },
              validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  labelText: "Select Category",
                ),
                // isDense: true,
                // validator: (dd)=> ,
                onSaved: (nV) {
                  log("Dropdown OnSaved $nV");
                  controller.singleItemData['category'] = nV.toString();
                },
                value: controller.categories[0],
                items: controller.categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.category, color: Theme.of(context).primaryColor),
                        ),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  log("Dropdown changed: - $val");
                  controller.singleItemData['category'] = val.toString();
                  log(controller.singleItemData.toString());
                },

                validator: (value) => value == null ? "Please select Category" : null,
              ),
            ),

            // // PoSInputField(label: "Manufactured on", hint: 'DD-MM-YYYY'),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  labelText: "Select sub-category",
                ),
                isDense: true,
                // validator: (dd) => 'required',
                onSaved: (nV) {
                  log("Dropdown OnSaved ");
                  controller.singleItemData['subcategory'] = nV.toString();
                },
                // hint: const Text("Select USER_ROLE"),
                value: controller.subCategories[0],
                items: controller.subCategories.map(
                  (String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(category),
                        ],
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  log("Dropdown changed: - $val");
                  controller.singleItemData['subcategory'] = val.toString();
                  log(controller.singleItemData.toString());
                },
                validator: (value) => value == null ? "Please select Sub-category" : null,
              ),
            ),
            PoSInputField(
              flex: 2,
              label: "Manufacturer",
              hint: 'Name of manufaturer',
              validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
              onChanged: (val) {
                controller.singleItemData['manufacturer'] = val;
              },
              controller: controller.manufacturerTextCtr,
            ),
            Row(
              children: [
                PoSInputField(
                  // readOnly: true,
                  onTap: () async {
                    Future? _exp = showDatePicker(
                      initialDatePickerMode: DatePickerMode.year,
                      context: context,
                      // currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                    );
                    controller.expDateTxtCtr.text = (await _exp ?? DateTime.now()).toString();
                    log(controller.singleItemData.toString());
                  },
                  label: "Expiry",
                  hint: 'MMMDD-YYYY',
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  // controller: controller.itemExpCtr,
                ),
                PoSInputField(
                  label: "HSN",
                  hint: 'HSN Code',
                  controller: controller.hsnTextCtr,
                  numbersOnly: true,
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (val) {
                    controller.singleItemData['hsn'] = val;
                  },
                ),
              ],
            ),
            Row(
              children: [
                PoSInputField(
                  label: "Batch no",
                  hint: 'BT00054',
                  controller: controller.batchTextCtr,
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (val) {
                    controller.singleItemData['batch'] = val;
                  },
                ),
                PoSInputField(
                  controller: controller.packSizeTextCtr,
                  label: "Pack Size",
                  hint: 'Size',
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (val) {
                    controller.singleItemData['packSize'] = val;
                  },
                ),
              ],
            ),

            //! ==========================================================================
            //! ==========================================================================
            const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Pricing"))),
            Row(
              children: [
                PoSInputField(
                  controller: controller.mrpTextCtr,
                  // flex: 2,
                  suffixText: "Rs",
                  label: "MRP",
                  hint: "MRP in Rs",
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  maxLength: 5,
                  onChanged: (val) {
                    controller.singleItemData['mrp'] = val;
                  },
                  numbersOnly: true,

                  // controller: controller.mrpCtr,
                ),
              ],
            ),
            Row(
              children: [
                PoSInputField(
                  controller: controller.rateTextCtr,
                  numbersOnly: true,
                  label: "Rate",
                  hint: "Rate",
                  onChanged: (val) {
                    controller.singleItemData['rate'] = val;
                  },
                  // controller: controller.rateCtr,
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  suffixText: "Rs",
                  maxLength: 5,
                ),
                //   PoSInputField(
                //     // flex: 2,
                //     label: "Purchase Price",
                //     hint: "Price",onChanged: (val) {
                //   controller.singleItemData[] = val;
                // },
                //     numbersOnly: true,
                //     maxLength: 5,
                //     validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                //     suffixText: "Rs",
                //     // controller: controller.purchasePriceCtr,
                //   ),
              ],
            ),

            //! ==========================================================================
            //! ==========================================================================
            const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Stock Count"))),
            Row(
              children: [
                // PoSInputField(
                //   numbersOnly: true,
                //   label: "Opening Stocks",
                //   hint: "Quantity",
                //   validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                //   suffixText: "Qty",
                //   maxLength: 4,
                // controller: controller.openingStocksCtr,
                // ),
                PoSInputField(
                  numbersOnly: true,
                  controller: controller.qtyTextCtr,
                  label: "Quantity",
                  hint: "Quantity",
                  suffixText: "Qty",
                  onChanged: (val) {
                    controller.singleItemData['qty'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  maxLength: 4,
                  // controller: controller.qtyCtr,
                ),
              ],
            ),
            //! ==========================================================================
            //! ==========================================================================
            const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Discount"))),
            Row(
              children: [
                PoSInputField(
                  label: "Discount",
                  controller: controller.discountTextCtr,
                  numbersOnly: true,
                  onChanged: (val) {
                    controller.singleItemData['discount'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  hint: "Discount in %",
                  suffixText: "%",
                  maxLength: 2,
                  // controller: controller.discountCtr,
                ),
                //
                PoSInputField(
                  controller: controller.discountQtyTextCtr,
                  label: "Discount(Qty)",
                  numbersOnly: true,
                  hint: "Discount ",
                  onChanged: (val) {
                    controller.singleItemData['discountQTY'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  // controller: controller.discountQtyCtr,
                  maxLength: 2,
                ),
              ],
            ),
            Row(
              children: [
                PoSInputField(
                  label: "TD%",
                  numbersOnly: true,
                  hint: "TD% ",
                  controller: controller.tdTextCtr,
                  onChanged: (val) {
                    controller.singleItemData['td'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  // controller: controller.tdCtr,
                  maxLength: 2,
                ),
                PoSInputField(
                  controller: controller.cdTextCtr,
                  label: "CD%",
                  numbersOnly: true,
                  hint: "CD%",
                  onChanged: (val) {
                    controller.singleItemData['cd'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  maxLength: 2,
                ),
              ],
            ),
            //! ==========================================================================
            //! ==========================================================================
            const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Tax"))),
            Row(
              children: [
                PoSInputField(
                  controller: controller.cgstTextCtr,
                  label: "CGST%",
                  numbersOnly: true,
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  hint: "CGST in%",
                  suffixText: "%",
                  maxLength: 2,
                  onChanged: (val) {
                    controller.singleItemData['cgst'] = val;
                  },
                  // controller: controller.cgstCtr,
                ),
                PoSInputField(
                  controller: controller.sgstTextCtr,
                  label: "SGST%",
                  numbersOnly: true,
                  hint: "SGST in%",
                  onChanged: (val) {
                    controller.singleItemData['cgst'] = val;
                  },
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  // controller: controller.sgstCtr,
                  suffixText: "%",
                  maxLength: 2,
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              // width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  OutlinedButton.icon(
                    icon: Icon(Icons.cancel),
                    style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {},
                    label: const Text("Cancel"),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (controller.purchaseItemsFormKey.currentState!.validate()) {
                        controller.items.add(controller.singleItemData);
                        controller.singleItemData = {};
                        controller.clearFormFields();
                        log(controller.items.toString());
                      } else {
                        MassengerScaffold.notifyUser(context, "Complete Form");
                      }
                    },
                    label: const Text("Add"),
                  ),
                ],
              ),
            ),
          ],
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
