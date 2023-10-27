import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pos/shop_manager/navbar_c.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';

// import 'package:http/http.dart' as http;

UserController userController = Get.find<UserController>();

class BaseURL {
  static const domain = "http://34.205.76.254:8085/";
  static const midURL = "pos/dev/";
  static const CompleteURL = domain + midURL;

  static var header = {'Content-Type': 'application/json'};
  static var authHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${userController.accessToken}',
  };
}

//
class ApiLink {
  // ! Authentication
  static const String login = BaseURL.CompleteURL + "auth/login";
  static const String verifyUserViaOTP = BaseURL.CompleteURL + "user/verify";
  static const String refreshAccessTokenLink = BaseURL.CompleteURL + "auth/refresh";
  // static const String verifyUser = BaseURL.CompleteURL + "user/"; // {"otp": "","verifyToken": ""}
  // static const String Link = BaseURL.CompleteURL + "";

// ! userr
  static const String addNewUser = BaseURL.CompleteURL + "user";
  // static const String getUser = BaseURL.CompleteURL + "user/";

  //! Parties
  static const String getVendors = BaseURL.CompleteURL + "vendor/"; // GET
  static const String getCustomers = BaseURL.CompleteURL + "customer/"; // GET
  static const String addCustomer = BaseURL.CompleteURL + "customer/"; // POST
  static const String deleteCustomer = BaseURL.CompleteURL + "customer/"; // DELETE
  static const String addVendor = BaseURL.CompleteURL + "vendor/"; // POST
  static const String deleteVendor = BaseURL.CompleteURL + "vendor/"; // DELETE

  //! Inventory items
  static const String getInventoryItems = BaseURL.CompleteURL + "product/";
  static const String addInventoryItem = BaseURL.CompleteURL + "product/";
}
