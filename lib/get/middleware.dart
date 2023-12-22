import 'package:get/get.dart';
import 'package:pos/get/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/navbar_c.dart';
import 'package:pos/pages/page_with_bottom_navbar.dart';

class AuthMiddleware extends GetMiddleware {
  // final authController = Get.put<AuthController>();
  AuthController authController = Get.put(AuthController());

  UserController controller = Get.put(UserController());

  @override
  int? get priority => 1;

  // @override
  // RouteSettings redirect(String route) {
  //   return authController.authenticated || route == '/login' ? null : RouteSettings(name: '/login');
  // }

  // @override
  // GetPage onPageCalled(GetPage page) {
  //   print('>>> Page ${page.name} called');
  //   print('>>> User ${authController.username} logged');
  //   return authController.username != null
  //       ? page.copyWith(parameter: {'user': authController.username})
  //       : page;
  // }

  @override
  GetPage? onPageCalled(GetPage? page) {
    authController.isAuth.value ? Get.toNamed(BottomNavigationBarPage.path) : Get.toNamed(Login.path);
    return super.onPageCalled(page);
  }

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
