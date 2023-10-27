import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/api.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:http/http.dart' as http;

class MyProfileController extends GetxController {
  //

  // Map body = {};
  // RxBool isLoading = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    Get.closeAllSnackbars();
    super.onClose();
  }

  // void refreshToken() async {
  //   Map _body = {"refreshToken": readData('refreshToken')};
  //   log("Body=>> $_body ");
  //   try {
  //     var res =
  //         await http.post(Uri.parse(ApiLink.refreshToken), body: json.encode(_body), headers: BaseURL.header);
  //     log("refreshing token status=>> [${res.statusCode}]");

  //     var _bodyData = json.decode(res.body);
  //     Map<String, String> _headerData = res.headers;
  //     if (res.statusCode == 201) {
  //       log("================== Success ================");
  //       print('Date ==>> ${_headerData["date"]}');
  //       writeData('date', _headerData['date']);
  //       print('Access Token ==>> ${_headerData["accesstoken"]}');
  //       writeData('accessToken', _headerData['accesstoken']);
  //       print('Refresh Token ==>> ${_headerData["refreshtoken"]}');
  //       writeData('refreshToken', _headerData['refreshtoken']);
  //       log("================== Success ==================");
  //       print(_bodyData.toString());
  //       // writeData('data', _bodyData);
  //       // getProfile();
  //       Get.closeAllSnackbars();
  //       Get.back();
  //       log("================== Success ===================");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future getProfile() async {
    // isLoading.value = true;
    try {
      var res = await APIServices.getMyProfile();
      log("Profile res=>>${res.statusCode}");
      var _bodyData = json.decode(res.body);
      log(_bodyData.toString());

      if (res.statusCode == 200) {
        log(_bodyData.toString());
        // body = _bodyData;
        // isLoading.value = false;
        log(_bodyData.toString());
        return _bodyData;
      } else if (res.statusCode == 403) {
        // showSnackbar("Alert", _bodyData['message'].toString());
        APIServices.refreshAccessToken(getProfile());
      } else {
        showSnackbar("Alert", _bodyData['message']);
        // return AsyncError(_bodyData['message'], StackTrace.current);
        // return AsyncSnapshot.withError(ConnectionState.done, [_bodyData['message'].toString()]);
      }
    } catch (e) {
      log(e.toString());
      showSnackbar("Error", e.toString());
      throw Exception(e);
    }

    //
  }
}//