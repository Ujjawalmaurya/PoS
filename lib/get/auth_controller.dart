import 'package:get/get.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/storage_keys.dart';

class AuthController extends GetxController {
  String userRole = readData(StorageKey.user.userData)["role"];
  String refreshToken = readData(StorageKey.user.refreshToken);
  String accessToken = readData(StorageKey.user.accessToken);
  RxBool isAuth = false.obs;

  @override
  void onInit() async {
    var profileRes = await APIServices.getMyProfile();

    if (profileRes.statusCode == 200) {
      isAuth.value = true;
    } else {
      var refreshRes = await APIServices.refreshAccessToken();
      if (refreshRes.statusCode == 200) {
        isAuth.value = true;
      } else {
        Get.offAllNamed(Login.path);
      }
    }
    // profileRes.then((value) {
    //   if (value != null) {
    //     isAuth.value = true;
    //   } else {
    //     isAuth.value = false;
    //   }
    // });
    super.onInit();
  }

  //
}// END