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
                  hint: "e.g., pen, bulb, Paracetamol", label: "Item Name", maxLines: 3, minLines: 1),

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

              PoSInputField(flex: 2, label: "Manufacturer", hint: 'Name of manufaturer'),
              PoSInputField(
                  label: "HSN", hint: 'HSN Code', textCapitalization: TextCapitalization.characters),
              PoSInputField(
                  label: "Batch no", hint: 'BT00054', textCapitalization: TextCapitalization.characters),
              PoSInputField(
                  label: "Pack Size", hint: 'Size', textCapitalization: TextCapitalization.characters),

              //! ==========================================================================
              //! ==========================================================================
              const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Pricing"))),
              Row(
                children: [
                  PoSInputField(flex: 3, label: "MRP", hint: "MRP in Rs", maxLength: 5, numbersOnly: true),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          const Text("Tax Included"),
                          Switch(
                            value: controller.isTaxable,
                            onChanged: (_val) => controller.isTaxable = _val,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              PoSInputField(
                  numbersOnly: true, label: "Sale Price", hint: "Price", suffixText: "INR", maxLength: 5),
              PoSInputField(
                  flex: 2,
                  label: "Purchase Price",
                  hint: "Price",
                  numbersOnly: true,
                  maxLength: 5,
                  suffixText: "INR"),

              //! ==========================================================================
              //! ==========================================================================
              const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Product Count"))),
              PoSInputField(
                numbersOnly: true,
                label: "Opening Stocks",
                hint: "Quantity",
                suffixText: "Qty",
                maxLength: 4,
              ),
              PoSInputField(
                numbersOnly: true,
                label: "Quantity",
                hint: "Quantity",
                suffixText: "Qty",
                maxLength: 4,
              ),
              //! ==========================================================================
              //! ==========================================================================
              const Align(alignment: Alignment.centerLeft, child: Chip(label: Text("Discount"))),
              PoSInputField(
                  label: "Discount", numbersOnly: true, hint: "GST in %", suffixText: "%", maxLength: 2),
              //
              PoSInputField(
                label: "Discount(Qty)",
                numbersOnly: true,
                hint: "Discount ",
                maxLength: 2,
              ),
              Row(
                children: [
                  PoSInputField(
                    label: "TD%",
                    numbersOnly: true,
                    hint: "TD% ",
                    maxLength: 2,
                  ),
                  PoSInputField(
                    label: "CD%",
                    numbersOnly: true,
                    hint: "CD%",
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
                    label: "C-GST%",
                    numbersOnly: true,
                    hint: "C-GST in%",
                    suffixText: "%",
                    maxLength: 2,
                  ),
                  PoSInputField(
                    label: "S-GST%",
                    numbersOnly: true,
                    hint: "S-GST in%",
                    suffixText: "%",
                    maxLength: 2,
                  ),
                ],
              ),

              // ElevatedButton(onPressed: () {}, child: Text("Add Item"))

              // PoSInputField(
              //     label: "Shelf life", hint: 'xyz', suffixText: "Months", numbersOnly: true, maxLength: 3),
              // PoSInputField(flex: 1, label: "Unit", hint: 'Unit of measurement'),
              PoSInputField(flex: 1, label: "Pack", hint: 'Unit'),

              // PoSInputField(label: "Manufactured on", hint: 'DD-MM-YYYY'),
              PoSInputField(label: "Expiry", hint: 'DD-MM-YYYY'),

              const SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
