import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/add_party/add_parties.dart';
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
        onPressed: () =>
            Get.toNamed(AddParties.path, arguments: controller.partyType == Type.customer ? 0 : 1),
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
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: BouncingScrollPhysics(),
                          itemCount: _.vendors.length,
                          itemBuilder: (context, index) {
                            var _data = _.vendors[index];
                            return SupplierTile(
                              name: _data.supplierName.toString(),
                              businessName: "${_data.businessName}",
                              onTap: () => controller.showVendorInfo(_data),
                              amount: 585.4,
                              amountType: "Total Amount",
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: BouncingScrollPhysics(),
                          itemCount: _.customers.length,
                          itemBuilder: (context, index) {
                            var _data = _.customers[index];
                            return CustomerTile(
                              onTap: () => controller.showCustomerInfo(_data),
                              name: _data.name.toString(),
                              amount: 585.4,
                              amountType: "Total Purchases",
                              subtitle: "${_data.email} ${_data.contact}",
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
