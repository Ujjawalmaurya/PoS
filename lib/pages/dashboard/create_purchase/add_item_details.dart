import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/src/constants/categories.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

import '../../../src/constants/sub_categories.dart';

class PurchaseItemForm extends GetWidget<PurchaseController> {
  static const path = '/putItemDetailsForPurchase';
  PurchaseItemForm({super.key});

  // PurchaseController purchaseController = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.purchaseItemsFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Add Items",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    IconButton.filled(
                        onPressed: () => controller.clearFormFields(), icon: const Icon(Icons.clear_all)),
                  ],
                ),
                PoSInputField(
                  controller: controller.itemNameTextCtr,
                  label: "Name",
                  hint: "Item Name",
                  // },
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
                      // controller.singleItemData['category'] = nV.toString();
                    },
                    // value: controller.categories[0],
                    value: controller.defaultCategory.isNotEmpty ? controller.defaultCategory : null,
                    items: categories.map((String category) {
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
                      controller.selectedCategory = val.toString();
                      // log(controller.singleItemData.toString());
                    },

                    validator: (value) => value == null ? "Please select Category" : null,
                  ),
                ),

                // // PoSInputField(label: "Manufactured on", hint: 'DD-MM-YYYY'),
                // Text("data"),
                // Obx(
                //   () =>
                controller.selectedCategory == 'Pharma'
                    ? SegmentedButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          ),
                        ),
                        showSelectedIcon: false,
                        segments: const <ButtonSegment<ProductType>>[
                          ButtonSegment<ProductType>(
                            value: ProductType.TABLET,
                            label: Text('Tablet '),
                            icon: Icon(Icons.dataset_outlined),
                          ),
                          ButtonSegment<ProductType>(
                            value: ProductType.SYRUP,
                            label: Text('Syrup '),
                            icon: Icon(Icons.stacked_bar_chart_outlined),
                          ),
                          ButtonSegment<ProductType>(
                            value: ProductType.CREAM,
                            label: Text('Cream '),
                            icon: Icon(Icons.catching_pokemon_sharp),
                          ),
                        ],
                        selected: <ProductType>{
                          controller.productType,
                        },
                        onSelectionChanged: (val) => {
                          controller.productType = val.first,
                          // _.updateProductType(val),
                        },
                      )
                    : const SizedBox.shrink(),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      labelText: "Select sub-category",
                    ),
                    // isDense: true,
                    onSaved: (nV) {
                      log("Dropdown OnSaved ");
                    },
                    value: controller.defaultSubCategory.isNotEmpty ? controller.defaultSubCategory : null,
                    items: subCategories.map(
                      (String subCategory) {
                        return DropdownMenuItem(
                          value: subCategory,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(subCategory),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      log("Dropdown changed: - $val");
                      controller.selectedSubCategory = val.toString();
                      //   log(controller.singleItemData.toString());
                    },
                    validator: (value) => value == null ? "Please select Sub-category" : null,
                  ),
                ),
                PoSInputField(
                  flex: 2,
                  label: "Manufacturer",
                  hint: 'Name of manufaturer',
                  validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                  // onChanged: (val) {
                  //   controller.singleItemData['manufacturer'] = val;
                  // },
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
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2030),
                        );
                        controller.itemExpiryDateTxtCtr.text =
                            (Utils.formatDate(await _exp ?? DateTime.now()));
                        // log(controller.singleItemData.toString());
                      },
                      label: "Item Expiry",
                      hint: 'MMMDD-YYYY',
                      readOnly: true,
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      controller: controller.itemExpiryDateTxtCtr,
                    ),
                    PoSInputField(
                      label: "HSN",
                      hint: 'HSN Code',
                      controller: controller.hsnTextCtr,
                      numbersOnly: true,
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      textCapitalization: TextCapitalization.characters,
                      // onChanged: (val) {
                      //   controller.singleItemData['hsn'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['batch'] = val;
                      // },
                    ),
                    PoSInputField(
                      controller: controller.packSizeTextCtr,
                      label: "Pack Size",
                      hint: 'Size',
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      textCapitalization: TextCapitalization.characters,
                      // onChanged: (val) {
                      //   controller.singleItemData['packSize'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['mrp'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['rate'] = val;
                      // },
                      // controller: controller.rateCtr,
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      suffixText: "Rs",
                      maxLength: 5,
                    ),
                    PoSInputField(
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      numbersOnly: true,
                      maxLength: 5,
                      label: "Loc",
                      hint: "LOC",
                      controller: controller.locTextCtr,
                    )
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
                      // onChanged: (val) {
                      //   controller.singleItemData['qty'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['discount'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['discountQTY'] = val;
                      // },
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
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
                      // onChanged: (val) {
                      //   controller.singleItemData['td'] = val;
                      // },
                      validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                      // controller: controller.tdCtr,
                      maxLength: 2,
                    ),
                    PoSInputField(
                      controller: controller.cdTextCtr,
                      label: "CD%",
                      numbersOnly: true,
                      hint: "CD%",
                      // onChanged: (val) {
                      //   controller.singleItemData['cd'] = val;
                      // },
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
                      // onChanged: (val) {
                      //   controller.singleItemData['cgst'] = val;
                      // },
                      // controller: controller.cgstCtr,
                    ),
                    PoSInputField(
                      controller: controller.sgstTextCtr,
                      label: "SGST%",
                      numbersOnly: true,
                      hint: "SGST in%",
                      // onChanged: (val) {
                      //   controller.singleItemData['cgst'] = val;
                      // },
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
                        icon: const Icon(Icons.cancel),
                        style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.red),
                        ),
                        onPressed: () {
                          log("Cancel clicked");
                        },
                        label: const Text("Cancel"),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (controller.purchaseItemsFormKey.currentState!.validate()) {
                            controller.insertItem();
                            controller.clearFormFields();
                          } else {
                            MassengerScaffold.notifyUser(context, "Complete Form");
                          }
                        },
                        label: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
