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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.partyController.customers.length,
                itemBuilder: (context, index) {
                  var customer = controller.partyController.customers[index];
                  return ListTile(
                    title: Text(customer.name.toString()),
                    trailing: Text(customer.contact.toString()),
                    subtitle: Text(customer.address.toString()),
                    onTap: () {
                      controller.selectedCustomer.value = controller.partyController.customers[index];
                      Get.back();
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: OutlinedButton.icon(
              onPressed: () => Get.toNamed('/addParties'),
              icon: const Icon(Icons.add),
              label: const Text("Add new Customer"),
            ),
          )
        ],
      ),
    );
  }
}
