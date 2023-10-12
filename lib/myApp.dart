import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/admin.dart';
import 'package:pos/get/get_pages.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/shop_boy/shopboy.dart';
import 'package:pos/shop_owner/shop_owner.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/theme/theme.dart';
import 'package:pos/shop_manager/page_with_bottom_navbar.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final String? role = readData('userData')?['role'];

  // Root Widget
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PoS Paperlessly',
      themeMode: ThemeMode.light,
      theme: PoSAppTheme.lightTheme,
      darkTheme: PoSAppTheme.darkTheme,
      getPages: Routes.pages,
      // home: route(),
      // initialRoute: '/bottomNavbar',
      initialRoute: role != null ? '/$role' : '/login',
    );
  }

  // route() {
  //   if (role == 'SALESMAN') return '/shopBoy';
  //   if (role == 'STORE_MANAGER') return '/bottomNavbar';
  //   if (role == 'STORE_OWNER') return '/shopOwner';
  //   if (role == 'ADMIN') {
  //     return '/admin';
  //   } else {
  //     return '/login';
  //   }
  // }
}
