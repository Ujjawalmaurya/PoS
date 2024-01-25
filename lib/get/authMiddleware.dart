import 'dart:developer';

import 'package:get/get.dart';
import 'package:pos/get/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/navbar_c.dart';
import 'package:pos/pages/page_with_bottom_navbar.dart';

class AuthMiddleware extends GetMiddleware {
  AuthController authController = Get.put(AuthController());

  @override
  int? get priority => 1;

  // @override
  // RouteSettings? redirect(String? route) {
  // Navigate to login if client is not authenticated other wise continue
  // log("Middleware routing ${authController.isAuth.value}", name: "=> middleware <=");
  // if (authController.isAuth.value) {
  // return const RouteSettings(name: BottomNavigationBarPage.path);
  //   return null;
  // } else {
  //   print('Not auth');
  //   return const RouteSettings(name: Login.path);
  // }
  // return null;
  // }

  // @override
  // List<Bindings> onBindingsStart(List<Bindings> bindings) {
  //   // This function will be called right before the Bindings are initialize,
  //   // then bindings is null
  //   bindings = [OtherBinding()];
  //   return bindings;
  // }

  // @override
  // GetPageBuilder onPageBuildStart(GetPageBuilder page) {
  //   print('Bindings of ${page.toString()} are ready');
  //   return page;
  // }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}
