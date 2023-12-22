import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/scanner/scanner.dart';
import 'package:pos/pages/dashboard/create_purchase/add_purchase.dart';
import 'package:pos/pages/dashboard/create_sale/add_sales.dart';
import 'package:pos/pages/dashboard/home_c.dart';
import 'package:pos/pages/dashboard/read_files.dart';
import 'package:pos/pages/dashboard/analytics.dart';
import 'package:pos/pages/navbar_c.dart';
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            dropdownColor: Theme.of(context).colorScheme.background,
            alignment: Alignment.topLeft,
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
                        return controller.actionType == callAnAction.sale
                            // * Sales
                            ? Obx(
                                () => controller.sales.isNotEmpty
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) => const Divider(),
                                        physics: const NeverScrollableScrollPhysics(),
                                        // itemCount: controller.sales.length,
                                        itemCount: controller.sales.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          var _saleData = controller.sales[index];
                                          return RecentSalesTile(
                                            name: 'Sale to customer ${index + 1}',
                                            amount: 123 * (index + 1) + (5 * index + 8),
                                          );
                                        },
                                      )
                                    : SizedBox(
                                        height: Get.height * 0.35,
                                        child: const Center(
                                          child: Text("No Sales"),
                                        ),
                                      ),
                              )
                            // * Purchases
                            : Obx(
                                () => controller.purchases.isNotEmpty
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) => const Divider(),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.purchases.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          Map _purchaseData = controller.purchases[index];
                                          return RecentPurchaseTile(
                                            onTap: () => Get.defaultDialog(
                                                title: "Data",
                                                content: SizedBox(
                                                  height: Get.height * 0.6,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        // Text("Purchase Data: "),
                                                        Text(
                                                            "Business Data: ${_purchaseData['businessDetails']}\n"),
                                                        Text("Vendor Data: ${_purchaseData['vendor']}\n"),
                                                        Text(
                                                            "Products(${_purchaseData['items'].length}): ${_purchaseData['items']}\n"),
                                                        // Text("Purchase Data: "),
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                            amount: 559 * index + (8 * (index + 1) + 8),
                                            invoiceNumber: "Invoice no: ${_purchaseData['invoiceNumber']}",
                                            name: "Sales man: ${_purchaseData['salesMan']}",
                                          );
                                        },
                                      )
                                    : SizedBox(
                                        height: Get.height * 0.35,
                                        child: const Center(
                                          child: Text("No Purchases"),
                                        ),
                                      ),
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
                          Text(
                            controller.actionType == callAnAction.sale ? "Add Sales" : "Add Purchase",
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      // style: ButtonStyle(elevation: MaterialStatePropertyAll(5)),
                      onPressed: () => controller.moreOptionsBbottomSheet(
                        context,
                        controller.actionType == callAnAction.sale
                            ? controller.moreSalesOption
                            : controller.morePurchaseOptions,
                        controller.actionType == callAnAction.sale ? 'sale' : 'purchase',
                      ),
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
