import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/inventory/add_inventory/add_inventory_c.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class AddInventory extends GetWidget<AddInventoryController> {
  const AddInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.addItemFormKey.currentState!.validate()) {
            controller.addItem();
          }
        },
        child: const Icon(Icons.check),
      ),
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
        child: Form(
          key: controller.addItemFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //! ==========================================================================
              //! ==========================================================================
              const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Product Details"))),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => controller.pickImage(context),
                  child: controller.itemImage == null
                      ? const MyDottedBorderWidget(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Icon(Icons.add_a_photo_outlined),
                          ),
                        )
                      : Image.file(File(controller.itemImage!.path),
                          fit: BoxFit.cover, height: 100, width: 100),
                ),
              ),
              PoSInputField(
                controller: controller.itemNameCtr,
                hint: "e.g., pen, bulb, Paracetamol",
                label: "Item Name",
                validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                maxLines: 3,
                minLines: 1,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Select Category",
                    ),
                    isDense: true,
                    // validator: (dd)=> ,
                    onSaved: (nV) {
                      log("Dropdown OnSaved ");
                    },
                    // hint: const Text("Select USER_ROLE"),
                    value: controller.defaultCategory.isNotEmpty ? controller.defaultCategory : null,
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
                          ));
                    }).toList(),
                    onChanged: (val) {
                      log("Dropdown changed: - $val");
                      controller.selectedCategory.value = val.toString();
                    },
                    validator: (value) => value.toString().trim().isEmpty ? "Please select role" : null,
                  ),
                ),
              ),

              // PoSInputField(label: "Manufactured on", hint: 'DD-MM-YYYY'),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Obx(
                  () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Select sub-category",
                    ),
                    isDense: true,
                    // validator: (dd) => 'required',
                    onSaved: (nV) {
                      log("Dropdown OnSaved ");
                    },
                    // hint: const Text("Select USER_ROLE"),
                    value: controller.defaultSubCategory.isNotEmpty ? controller.defaultSubCategory : null,
                    items: controller.subCategories.map((String category) {
                      return DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(Icons.calendar_today_outlined,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(category),
                            ],
                          ));
                    }).toList(),
                    onChanged: (val) {
                      log("Dropdown changed: - $val");
                      controller.selectedSubCategory.value = val.toString();
                    },
                    validator: (value) => value.toString().trim() == '' ? "Please select Sub-category" : null,
                  ),
                ),
              ),

              PoSInputField(
                flex: 2,
                label: "Manufacturer",
                hint: 'Name of manufaturer',
                validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                controller: controller.manufacturerCtr,
              ),
              Row(
                children: [
                  PoSInputField(
                    label: "Expiry",
                    hint: 'DD-MM-YYYY',
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    controller: controller.itemExpCtr,
                  ),
                  PoSInputField(
                    label: "HSN",
                    hint: 'HSN Code',
                    controller: controller.hsnCtr,
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
                    controller: controller.batchCtr,
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  PoSInputField(
                    label: "Pack Size",
                    hint: 'Size',
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    controller: controller.packSizeCtr,
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
                    label: "MRP",
                    hint: "MRP in Rs",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    maxLength: 5,
                    numbersOnly: true,
                    controller: controller.mrpCtr,
                  ),
                  Flexible(
                    // flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Tax Included"),
                          Obx(
                            () => Switch(
                              value: controller.isTaxable.value,
                              onChanged: (_val) => controller.isTaxable.value = _val,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  PoSInputField(
                    numbersOnly: true,
                    label: "Rate",
                    hint: "Rate",
                    controller: controller.rateCtr,
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    suffixText: "INR",
                    maxLength: 5,
                  ),
                  PoSInputField(
                    // flex: 2,
                    label: "Purchase Price",
                    hint: "Price",
                    numbersOnly: true,
                    maxLength: 5,
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    suffixText: "INR",
                    controller: controller.purchasePriceCtr,
                  ),
                ],
              ),

              //! ==========================================================================
              //! ==========================================================================
              const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Stock Count"))),
              Row(
                children: [
                  PoSInputField(
                    numbersOnly: true,
                    label: "Opening Stocks",
                    hint: "Quantity",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    suffixText: "Qty",
                    maxLength: 4,
                    controller: controller.openingStocksCtr,
                  ),
                  PoSInputField(
                    numbersOnly: true,
                    label: "Quantity",
                    hint: "Quantity",
                    suffixText: "Qty",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    maxLength: 4,
                    controller: controller.qtyCtr,
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
                    controller: controller.discountCtr,
                  ),
                  //
                  PoSInputField(
                    label: "Discount(Qty)",
                    numbersOnly: true,
                    hint: "Discount ",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    controller: controller.discountQtyCtr,
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
                    controller: controller.tdCtr,
                    maxLength: 2,
                  ),
                  PoSInputField(
                    label: "CD%",
                    numbersOnly: true,
                    hint: "CD%",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    controller: controller.cdCtr,
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
                    controller: controller.cgstCtr,
                  ),
                  PoSInputField(
                    label: "SGST%",
                    numbersOnly: true,
                    hint: "SGST in%",
                    validator: (p0) => p0.toString().trim() == '' ? 'Cannot be empty' : null,
                    controller: controller.sgstCtr,
                    suffixText: "%",
                    maxLength: 2,
                  ),
                ],
              ),

              // ElevatedButton(onPressed: () {}, child: Text("Add Item")),

              // PoSInputField(
              //     label: "Shelf life", hint: 'xyz', suffixText: "Months", numbersOnly: true, maxLength: 3),
              // PoSInputField(flex: 1, label: "Unit", hint: 'Unit of measurement'),

              const SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
