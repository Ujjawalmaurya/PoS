import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/home.dart';
import 'package:pos/shop_manager/inventory/stocks.dart';
import 'package:pos/shop_manager/marketing/marketing.dart';
import 'package:pos/shop_manager/parties/parties.dart';

class BottomNavigationBarController extends GetxController {
// final MyRepository repository;
// BottomNavBarController(this.repository);

  final List<Widget> widgetOptions = <Widget>[
    const TabOne(),
    Parties(),
    const Stocks(),
    Marketing(),
  ];

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.person_rounded,
    Icons.grid_view_outlined,
    Icons.settings_rounded,
  ];

  List<String> listOfStrings = [
    'Home',
    'Parties',
    'Stocks',
    'Marketing',
  ];

  RxInt currentIndex = 0.obs;
  final Duration animationDuration = const Duration(seconds: 1);

  void updateIndex() {
    //
  }

  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
