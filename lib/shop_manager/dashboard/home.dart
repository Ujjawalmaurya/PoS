import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/scanner/scanner.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/add_purchase.dart';
import 'package:pos/shop_manager/dashboard/create_sale/add_sales.dart';
import 'package:pos/shop_manager/dashboard/home_c.dart';
import 'package:pos/shop_manager/dashboard/read_files.dart';
import 'package:pos/shop_manager/dashboard/analytics.dart';
import 'package:pos/shop_manager/navbar_c.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/recent_purchase_tile.dart';
import 'package:pos/src/widgets/recent_sales_tile.dart';

class TabOne extends GetWidget<HomeController> {
  const TabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<UserController>().navbarScaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          // title: TextField(
          //   controller: controller.businessCtr,
          //   decoration: const InputDecoration(
          //     fillColor: Colors.transparent,
          //     hintText: "Business DD",
          //     border: InputBorder.none,
          //   ),
          // ),
          centerTitle: false,
          title: DropdownButtonFormField(
            // alignment: Alignment.topLeft,
            // isDense: true,
            decoration: const InputDecoration(border: InputBorder.none, fillColor: Colors.transparent),
            onSaved: (nV) {},
            value: controller.businesses[0],
            items: controller.businesses.map((String business) {
              return DropdownMenuItem(
                value: business,
                child: Text(business),
              );
            }).toList(),
            onChanged: (val) {
              // TODO:
            },
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Scanner.path),
              icon: const Icon(Icons.qr_code_2),
            ),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select file type"),
                  actions: [
                    OutlinedButton(
                      onPressed: () => pickXLFile(context),
                      child: const Text("Read Excel file"),
                    ),
                    OutlinedButton(
                      onPressed: () => pickCSVFile(context),
                      child: const Text("Read CSV file"),
                    ),
                  ],
                ),
              ),
              icon: const Icon(Icons.data_array_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Analytics(),
                    // const RecentTransactions(),
                    // const BillInvoice(),
                    // const SalesAndPurchases(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<HomeController>(
                        init: HomeController(),
                        initState: (_) {},
                        builder: (_) {
                          return SegmentedButton(
                            showSelectedIcon: false,
                            segments: const <ButtonSegment<callAnAction>>[
                              ButtonSegment<callAnAction>(
                                value: callAnAction.sale,
                                label: Text('Add sales'),
                                icon: Icon(Icons.arrow_circle_up_sharp),
                              ),
                              ButtonSegment<callAnAction>(
                                value: callAnAction.purchase,
                                label: Text('Add Purchase '),
                                icon: Icon(Icons.arrow_circle_down_outlined),
                              ),
                            ],
                            selected: <callAnAction>{controller.actionType},
                            onSelectionChanged: (val) => controller.updateCallAction(val),
                          );
                        },
                      ),
                    ),
                    // actionType == callAnAction.sale ? Sale() : Purchase()
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      initState: (_) {},
                      builder: (_) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.actionType == callAnAction.sale ? 20 : 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return controller.actionType == callAnAction.sale
                                ? RecentSalesTile(
                                    name: 'Sale to customer ${index + 1}',
                                    amount: 123 * (index + 1) + (5 * index + 8),
                                  )
                                : RecentPurchaseTile(
                                    name: "Purchase from supplier ${index + 1}",
                                    amount: 559 * index + (8 * (index + 1) + 8),
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<HomeController>(
              init: HomeController(),
              initState: (_) {},
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onLongPress: () => Utils.getUUID(),
                      onPressed: () => controller.actionType == callAnAction.sale
                          ? Get.toNamed(AddSales.path)
                          : Get.toNamed(AddPurchase.path),
                      child: Row(
                        children: [
                          const Icon(Icons.add_circle_outline),
                          Text(controller.actionType == callAnAction.sale ? "Add Sales" : "Add Purchase"),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => controller.moreOptionsBbottomSheet(
                          context,
                          controller.actionType == callAnAction.sale
                              ? controller.moreSalesOption
                              : controller.morePurchaseOptions,
                          controller.actionType == callAnAction.sale ? 'sale' : 'purchase'),
                      child: const Column(
                        children: [
                          Text("More"),
                          Text("Payment & Return"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
