import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';

class ShowCustomersForSale extends GetWidget<AddSalesController> {
  const ShowCustomersForSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Customer"),
      ),
      body: SizedBox(
        child: ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.customers[index]['name']),
                onTap: () {
                  controller.selectedCustomer.value = controller.customers[index];
                  Get.back();
                },
              );
            }),
      ),
    );
  }
}
