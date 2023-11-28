import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class PutItemDetails extends GetWidget<PurchaseController> {
  static const path = '/putItemDetailsForPurchase';
  PutItemDetails({super.key});

  // PurchaseController purchaseController = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    controller.index.value = 0;
    var data = controller.items[controller.index.value];
    log("DATA=> ${data}");
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Text(
                      "Add more about(${controller.index.value + 1}/${controller.items.length})",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.items[controller.index.value]['name'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const Divider(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            log("Dropdown OnSaved ");
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
                            // controller.selectedCategory = val.toString();
                            controller.items[controller.index.value]['category'] = val.toString();
                            log(data.toString());
                          },
                          validator: (value) => value == null ? "Please select Category" : null,
                        ),
                      ),

                      // PoSInputField(label: "Manufactured on", hint: 'DD-MM-YYYY'),

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
                            controller.selectedSubCategory = val.toString();
                          },
                          validator: (value) => value == null ? "Please select Sub-category" : null,
                        ),
                      ),
                      PoSInputField(
                        flex: 2,
                        label: "Manufacturer",
                        hint: 'Name of manufaturer',
                        validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                        // controller: controller.manufacturerCtr,
                      ),
                      Row(
                        children: [
                          PoSInputField(
                            readOnly: true,
                            onTap: () async {
                              Future? _exp = showDatePicker(
                                initialDatePickerMode: DatePickerMode.year,
                                context: context,
                                // currentDate: DateTime.now(),
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2030),
                              );
                              // controller.itemExpCtr.text = (await _exp ?? DateTime.now()).toString();
                            },
                            label: "Expiry",
                            hint: 'MMMDD-YYYY',
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            // controller: controller.itemExpCtr,
                          ),
                          PoSInputField(
                            label: "HSN",
                            hint: 'HSN Code',
                            // controller: controller.hsnCtr,
                            numbersOnly: true,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          PoSInputField(
                            label: "Batch no",
                            hint: 'BT00054',
                            // controller: controller.batchCtr,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          PoSInputField(
                            label: "Pack Size",
                            hint: 'Size',
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            // controller: controller.packSizeCtr,
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ],
                      ),

                      //! ==========================================================================
                      //! ==========================================================================
                      const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Pricing"))),
                      Row(
                        children: [
                          PoSInputField(
                            // flex: 2,
                            suffixText: "Rs",
                            label: "MRP",
                            hint: "MRP in Rs",
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            maxLength: 5,
                            numbersOnly: true,

                            // controller: controller.mrpCtr,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          PoSInputField(
                            numbersOnly: true,
                            label: "Rate",
                            hint: "Rate",
                            // controller: controller.rateCtr,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            suffixText: "Rs",
                            maxLength: 5,
                          ),
                          PoSInputField(
                            // flex: 2,
                            label: "Purchase Price",
                            hint: "Price",
                            numbersOnly: true,
                            maxLength: 5,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            suffixText: "Rs",
                            // controller: controller.purchasePriceCtr,
                          ),
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
                            label: "Quantity",
                            hint: "Quantity",
                            suffixText: "Qty",
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
                            numbersOnly: true,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            hint: "Discount in %",
                            suffixText: "%",
                            maxLength: 2,
                            // controller: controller.discountCtr,
                          ),
                          //
                          PoSInputField(
                            label: "Discount(Qty)",
                            numbersOnly: true,
                            hint: "Discount ",
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
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            // controller: controller.tdCtr,
                            maxLength: 2,
                          ),
                          PoSInputField(
                            label: "CD%",
                            numbersOnly: true,
                            hint: "CD%",
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            // controller: controller.cdCtr,
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
                            label: "CGST%",
                            numbersOnly: true,
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            hint: "CGST in%",
                            suffixText: "%",
                            maxLength: 2,
                            // controller: controller.cgstCtr,
                          ),
                          PoSInputField(
                            label: "SGST%",
                            numbersOnly: true,
                            hint: "SGST in%",
                            validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                            // controller: controller.sgstCtr,
                            suffixText: "%",
                            maxLength: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () => {
                            controller.index -= 1,
                            log(controller.index.toString()),
                          },
                          child: const Text("Back"),
                        ),
                        OutlinedButton(
                          onPressed: () => {
                            controller.index += 1,
                            log(controller.index.toString()),
                          },
                          child: const Text("Next"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
