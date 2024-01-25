import 'dart:developer';

import 'package:get/get.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/page_with_bottom_navbar.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/storage_keys.dart';

class AuthController extends GetxController {
  // String userRole = readData(StorageKey.user.userData)["role"] ?? 'null';
  // String refreshToken = readData(StorageKey.user.refreshToken) ?? 'null';
  // String accessToken = readData(StorageKey.user.accessToken) ?? 'null';
  RxBool isAuth = false.obs;

  @override
  void onInit() async {
    await checkAuth();
    super.onInit();
  }

  checkAuth() async {
    if (readData(StorageKey.user.accessToken) == null) {
      isAuth.value = false;
      //  Get.offAllNamed(Login.path);
      print("Null access token");
    } else {
      var profileRes = await APIServices.getMyProfile();
      if (profileRes?.statusCode == 200) {
        isAuth.value = true;
        //  Get.offAllNamed(BottomNavigationBarPage.path);
      } else {
        var refreshRes = await APIServices.refreshAccessToken();
        if (refreshRes?.statusCode == 200) {
          isAuth.value = true;
          //  Get.offAllNamed(BottomNavigationBarPage.path);
        } else {
          // log("Login route");
          isAuth.value = false;
          // Get.offAllNamed(Login.path);
        }
      }
    }
  }

  //
}// END