import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/src/constants/constants.dart';

enum callAnAction { sale, purchase }

class HomeController extends GetxController {
// final MyRepository repository;
// ManagerHomeController(this.repository);

  final TextEditingController businessCtr = TextEditingController(text: "");
  callAnAction actionType = callAnAction.sale;

  List moreSalesOption = [
    {
      'color': Colors.pinkAccent,
      'icon': Icons.blur_circular_sharp,
      'title': 'Credit note',
      'onpress': () {},
    },
    {
      'icon': Icons.payments,
      'color': Colors.lightBlue,
      'onpress': () {},
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
      'title': 'Purchase Order',
    },
  ];

  List morePurchaseOptions = [
    {
      'color': Colors.tealAccent,
      'icon': Icons.blur_circular_sharp,
      'title': 'Purchase Return',
      'onpress': () {},
    },
    {
      'icon': Icons.payments,
      'color': Colors.yellow,
      'onpress': () {},
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
      'onpress': () {},
      'title': 'Purchase Order',
    },
  ];

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
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

  void logout(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Do you really want to logout??"),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => ((readData('closeAppOnLogout') ?? false) && Platform.isAndroid)
                ? storage.erase().then(
                      (value) => Get.back(),
                    )
                : storage.erase().then((value) => Get.offAllNamed('/login')),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
  // Popping out of screen

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
                  crossAxisCount: 4, crossAxisSpacing: 0.0, mainAxisSpacing: 24.0),
              itemBuilder: (BuildContext context, int index) {
                var data = gridData[index];
                return GestureDetector(
                  onTap: (() => log('Found ${data['title']}')),
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
                            size: 30,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          data['title'],
                          textAlign: TextAlign.center,
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
