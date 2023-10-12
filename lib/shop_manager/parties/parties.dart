import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/party_c.dart';
import 'package:pos/src/widgets/party_tiles.dart';
import 'package:pos/src/widgets/search_field.dart';

class Parties extends GetWidget<PartyController> {
  Parties({super.key});

  // void showAddParties(context) {
  //   showBottomSheet(
  //     context: context,
  //     builder: (context) => const AddParties(),
  //   );
  // }

  // List<Map> supplier = [
  //   {
  //     'name': 'Supplier',
  //     'amount': 67,
  //     'amountType': 'To Recieve',
  //   },
  //   {
  //     'name': 'Supplier',
  //     'amount': 75,
  //     'amountType': 'To Pay',
  //   },
  // ];

  // List<Map> customer = [
  //   {
  //     'name': 'Customer',
  //     'amount': 67,
  //     'amountType': 'To Pay',
  //   },
  //   {
  //     'name': 'Customer',
  //     'amount': 234,
  //     'amountType': 'To Recieve',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    // final _p = ref.watch(partyListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: true,
        title: const Text("Parties"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addParties'),
        tooltip: "Add Parties",
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Text(
      //   "Parties",
      //   style: Theme.of(context).textTheme.headlineLarge,
      //   textAlign: TextAlign.center,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<PartyController>(
                init: PartyController(),
                initState: (_) {},
                builder: (_) {
                  return SegmentedButton(
                    segments: const <ButtonSegment<Type>>[
                      ButtonSegment<Type>(
                        value: Type.customer,
                        label: Text('Customer'),
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                      ),
                      ButtonSegment<Type>(
                        value: Type.supplier,
                        label: Text('Vendor'),
                        icon: Icon(
                          Icons.shopify_rounded,
                        ),
                      ),
                    ],
                    selected: <Type>{controller.partyType},
                    onSelectionChanged: (_val) {
                      // setState(() {
                      _.updatePartyType(_val);
                      // });
                    },
                  );
                },
              ),
            ),
            const SearchField(),
            Flexible(
              child: GetBuilder<PartyController>(
                init: PartyController(),
                initState: (_) {},
                builder: (_) {
                  return _.partyType == Type.supplier
                      ? ListView.builder(
                          itemCount: _.vendors.length,
                          itemBuilder: (context, index) {
                            var _data = _.vendors[index];
                            return SupplierTile(
                              name: _data['supplierName'],
                              businessName: "${_data['businessName']}",
                              onTap: () => Get.defaultDialog(),
                              amount: 585.4,
                              amountType: "to Pay",
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: _.customers.length,
                          itemBuilder: (context, index) {
                            var _data = _.customers[index];
                            return CustomerTile(
                              onTap: () => Get.defaultDialog(),
                              name: _data['name'],
                              amount: 585.4,
                              amountType: "to Pay",
                              subtitle: "${_data['email']}",
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
