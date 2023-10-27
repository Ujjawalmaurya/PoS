import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pos/shop_manager/parties/add_party/add_party_c.dart';
import 'package:pos/shop_manager/parties/add_party/forms/customer_form.dart';
import 'package:pos/shop_manager/parties/add_party/forms/supplier_form.dart';

class AddParties extends GetWidget<AddPartyController> {
  int initialIndex = Get.arguments;
  // int initialIndex = 0;
  AddParties({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: initialIndex ?? 0,
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
              addCustomerForm(controller),
              addVendorForm(controller),
            ],
          ),
        ),
      ),
    );
  }
}

// }
