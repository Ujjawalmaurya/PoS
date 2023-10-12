import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/add_party/add_party_c.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class AddParties extends GetWidget<AddPartyController> {
  const AddParties({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: const Icon(Icons.check),
          // ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            title: const Text("Add Party"),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.add_box_outlined),
                  text: "Customer",
                ),
                Tab(
                  icon: Icon(Icons.add_business_outlined),
                  text: "Vendor",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Form(
                key: controller.customerFormKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PoSInputField(
                        controller: controller.cName,
                        label: "Customer Name",
                        hint: "Full Customer Name",
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                      ),
                      // Row(
                      //   children: [
                      PoSInputField(
                        controller: controller.cNumber,
                        label: "Contact Number",
                        hint: "9876543210",
                        maxLength: 10,
                        prefixText: "+91",
                        validator: (p0) => p0.toString().trim().length < 10 ? "Cant be empty" : null,
                      ),
                      PoSInputField(
                        label: "E-mail",
                        controller: controller.cEmail,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        hint: "Email address",
                      ),
                      //   ],
                      // ),
                      PoSInputField(
                        label: "Address",
                        controller: controller.cAddress,
                        hint: "Full address",
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        maxLines: 2,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (controller.customerFormKey.currentState!.validate()) {
                            controller.addCustomer();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add new Customer"),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: controller.vendorFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Chip(
                          label: Text("Supplier Details"),
                        ),
                      ),
                      PoSInputField(
                        label: "Supplier Name",
                        hint: "Full Supplier Name",
                        controller: controller.vName,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                      ),
                      PoSInputField(
                        label: "Supplier Contact Number",
                        hint: "Contact number",
                        maxLength: 10,
                        controller: controller.vNumber,
                        validator: (p0) => p0.toString().trim().length < 10 ? "Must be 10 numbers" : null,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Chip(
                          label: Text("Business Details"),
                        ),
                      ),
                      PoSInputField(
                        label: "Name of Business",
                        hint: "Business name",
                        controller: controller.vBName,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                      ),
                      PoSInputField(
                        label: "Name of Business Owner",
                        controller: controller.vBOwnerName,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        hint: "Business Owner Name",
                      ),
                      PoSInputField(
                        controller: controller.vBAddress,
                        label: "Business Address",
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        hint: "Business Address",
                      ),
                      Row(
                        children: [
                          PoSInputField(
                            label: "Business Email",
                            controller: controller.vBEmail,
                            validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                            hint: "Business Email",
                          ),
                          // PoSInputField(
                          //   maxLength: 10,
                          //   label: "Business Phone Number",
                          //   controller: controller.vBNumber,
                          //   validator: (p0) => p0.toString().trim().length < 10 ? "Cant be empty" : null,
                          //   hint: "Business Phone",
                          // ),
                        ],
                      ),
                      PoSInputField(
                        label: "Drug Licence",
                        controller: controller.vDrugLicense,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        hint: "Licence",
                      ),
                      PoSInputField(
                        label: "GST Number",
                        controller: controller.vGST,
                        hint: "Ex: 12AAABB3456C7ZY",
                        maxLength: 16,
                        validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      // PoSInputField(
                      //   label: "PAN Number",
                      //   controller: controller.vPAN,
                      //   hint: "Ex: AAACC1234D",
                      //   maxLength: 10,
                      //   validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
                      //   textCapitalization: TextCapitalization.characters,
                      // ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (controller.vendorFormKey.currentState!.validate()) {
                            controller.addVendor();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("New Vendor/Supplier"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
