import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_sale/sales_c.dart';
import 'package:pos/pages/parties/add_party/add_parties.dart';
import 'package:pos/src/widgets/lazy_network_image.dart';
import 'package:pos/src/widgets/search_field.dart';

class ShowCustomersForSale extends GetWidget<AddSalesController> {
  static const String path = '/showCustomersForSale';
  const ShowCustomersForSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Customer"),
      ),
      body: Column(
        children: [
          const SearchField(),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.partyController.customers.length,
                itemBuilder: (context, index) {
                  var customer = controller.partyController.customers[index];
                  return Card(
                    child: ListTile(
                      leading: const NetworkImageLoader(image: 'https://robohash.org/odioquivero.png'),
                      isThreeLine: true,
                      title: Text(customer.name.toString()),
                      trailing: Text(customer.contact.toString()),
                      subtitle: Text(customer.address.toString()),
                      onTap: () {
                        controller.selectedCustomer.value = controller.partyController.customers[index];
                        Get.back();
                      },
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: OutlinedButton.icon(
              onPressed: () => Get.toNamed(AddParties.path, arguments: 0),
              icon: const Icon(Icons.add),
              label: const Text("Add new Customer"),
            ),
          )
        ],
      ),
    );
  }
}
