import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/dashboard/more_pages/credit_note.dart';
import 'package:pos/pages/dashboard/more_pages/debt_note.dart';
import 'package:pos/pages/dashboard/more_pages/purchase_order.dart';
import 'package:pos/pages/dashboard/more_pages/purchase_return.dart';
import 'package:pos/pages/dashboard/more_pages/sales_return.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';

enum callAnAction { sale, purchase }

class HomeController extends GetxController {
// final MyRepository repository;
// ManagerHomeController(this.repository);

  final TextEditingController businessCtr = TextEditingController(text: "");
  callAnAction actionType = callAnAction.sale;

  List<String> businesses = ['Business1', 'Business2', 'Business3'];

  RxString selectedBusiness = ''.obs;

  RxList sales = [].obs;
  RxList purchases = [].obs;
  //   {
  //    "id": 8,
  //    "invoiceNumber": "PURUJJ202312038",
  //    "preCreatedInvoice": "13234123",
  //    "preCreatedDate": "2023-12-02T00:00:00.000+00:00",
  //    "salesMan": "Dummy Supplier",
  //    "businessDetails": {
  //       "id": 1,
  //       "name": "Ujjawal medical",
  //       "type": "medical",
  //       "description": "Medicines for td",
  //       "contact": "780584487",
  //       "address": "Noida sector 59",
  //       "drugLicense": "dgt567dgh",
  //       "fileName": "null",
  //       "termsAndConditions": "null",
  //       "products": [],
  //       "customers": [],
  //       "vendors": []
  //    },
  //    "vendor": {
  //       "id": 9,
  //       "uuid": "975916b0-2f37-1d62-abd5-19b6d9d7c593",
  //       "supplierName": "Dummy Supplier",
  //       "supplierNumber": "8374937493",
  //       "businessName": "Dummy products LTD",
  //       "businessOwner": "Dumb Owner",
  //       "businessEmail": "BrooksideHsuebwjwj@jsjd.Sjjs",
  //       "businessAddress": "BB idk khud DM ki",
  //       "gstNumber": "J37TU48T93JR999L",
  //       "drugLicense": "73J48T75I29JD83U58D",
  //       "contact": null,
  //       "website": null
  //    },
  //    "items": [
  //       {
  //          "uuid": "01e65f6d-9de9-4c2a-925f-bc93492cb713",
  //          "product": {
  //             "id": 30,
  //             "name": "ietmmm",
  //             "type": "TABLET",
  //             "category": "Pharma",
  //             "subCategory": "Pain Relief",
  //             "hsn": 123424,
  //             "manufacturer": "feesfdserf",
  //             "unit": "string",
  //             "batchNum": "1234rf3",
  //             "discQty": 44,
  //             "discountPerProduct": 54,
  //             "loc": "234fv",
  //             "mrp": 23,
  //             "rate": 223,
  //             "totalAmount": 3000,
  //             "td": 3,
  //             "qty": 0,
  //             "cd": 2,
  //             "quantityParent": 8,
  //             "quantityChild": 0,
  //             "quantityMax": 34,
  //             "vendorId": 9,
  //             "expiry": "2030-01-01T00:00:00.000+00:00"
  //          },
  //          "quantityParent": 8,
  //          "quantityChild": 0,
  //          "quantityMax": 34,
  //          "isItemReturned": "N"
  //       }
  //    ],
  //    "category": "Pharma"
  // }

  List moreSalesOption = [
    {
      'color': Colors.pinkAccent,
      'icon': Icons.blur_circular_sharp,
      'title': 'Credit note',
      'onpress': () => Get.to(const CreditNote()),
    },
    {
      'icon': Icons.payments,
      'color': Colors.lightBlue,
      'onpress': () => Get.to(const SalesReturn()),
      'title': 'Sales Return',
    },
    {
      'color': Colors.red,
      'icon': Icons.point_of_sale_sharp,
      'onpress': () {},
      'title': 'Payment in',
    },
    {
      'color': Colors.yellow,
      'icon': Icons.escalator_outlined,
      'onpress': () {},
      'title': 'Quotation/\nEstimation',
    },
    {
      'color': Colors.greenAccent,
      'icon': Icons.delivery_dining,
      'onpress': () {
        print('sales');
      },
      'title': 'Delivery \nChallan',
    },
    {
      'color': Colors.purple,
      'icon': Icons.inventory_outlined,
      'onpress': () {
        print('sales');
      },
      'title': 'Sales Order',
    },
  ];

  List morePurchaseOptions = [
    {
      'color': Colors.tealAccent,
      'icon': Icons.blur_circular_sharp,
      'title': 'Purchase Return',
      'onpress': () => Get.to(const PurchaseReturn()),
    },
    {
      'icon': Icons.payments,
      'color': Colors.yellow,
      'onpress': () => Get.to(const DebtNote()),
      'title': 'Debt note',
    },
    {
      'color': Colors.red,
      'icon': Icons.money_off_csred_sharp,
      'onpress': () {},
      'title': 'Payment out',
    },
    {
      'color': Colors.deepPurple,
      'icon': Icons.escalator_outlined,
      'onpress': () => Get.to(const PurchaseOrder()),
      'title': 'Purchase Order',
    },
  ];

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    sales.value = await APIServices.getSales();
    purchases.value = await APIServices.getPurchases();
    super.onInit();
  }

  @override
  void onReady() {
    requestPermission();
    super.onReady();
  }

  updateCallAction(Set<callAnAction> _val) {
    actionType = _val.first;
    update();
  }

  // List getSales() {
  //
  // log("Getting sales");
  // var res = APIServices.getSales();
  // return [];
  // }

  // void getPurchases() async {
  //
  // purchases.value = await APIServices.getPurchases();
  // log("Getting purchases");
  // return purchases;
  // return [
  //   {},
  //   {},
  //   {},
  // ];
  // }

  requestPermission() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await Permission.storage.request().then((value) => log(value.name));

      // I noticed that sometimes popup won't show after user press deny
      // so I do the check once again but now go straight to appSettings
      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Here open app settings for user to manually enable permission in case
      // where permission was permanently denied
      await openAppSettings();
    } else {
      // Do stuff that require permission here
    }
  }

  void moreOptionsBbottomSheet(context, List gridData, String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          // Container(
          // height: 300,
          // decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          // child:
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Options",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: gridData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 22.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                var data = gridData[index];
                return GestureDetector(
                  onTap: data['onpress'],
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: CircleAvatar(
                          backgroundColor: data['color'].withAlpha(70),
                          radius: 30,
                          child: Icon(
                            data['icon'],
                            color: data['color'].shade700,
                            size: 32,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: FittedBox(
                          child: Text(
                            data['title'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              height: 50,
              // color: Colors.greenAccent,
              decoration: const BoxDecoration(
                  // color: Colors.redAccent,
                  ),
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  type == 'sale' ? "Purchase Options" : "More Sale Option",
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
