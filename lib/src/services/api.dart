import 'dart:convert';
import 'dart:developer';

import 'package:pos/src/constants/constants.dart';

// import 'package:http/http.dart' as http;

class BaseURL {
  static const domain = "http://34.205.76.254:8085/";
  static const midURL = "pos/dev/";
  static const CompleteURL = domain + midURL;

  static var header = {'Content-Type': 'application/json'};
  static var authHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${readData("accessToken")}'
  };
}

//
class ApiLink {
  // ! Authentication
  static const String login = BaseURL.CompleteURL + "auth/login";
  static const String verifyUserViaOTP = BaseURL.CompleteURL + "user/verify";
  static const String refreshToken = BaseURL.CompleteURL + "auth/refresh";
  // static const String verifyUser = BaseURL.CompleteURL + "user/"; // {"otp": "","verifyToken": ""}
  // static const String Link = BaseURL.CompleteURL + "";

// ! userr
  static const String addNewUser = BaseURL.CompleteURL + "user";
  // static const String getUser = BaseURL.CompleteURL + "user/";

  //! Parties
  static const String getVendors = BaseURL.CompleteURL + "vendor/"; // GET
  static const String getCustomers = BaseURL.CompleteURL + "customer/"; // GET
  static const String addCustomer = BaseURL.CompleteURL + "customer/"; // POST
  static const String addVendor = BaseURL.CompleteURL + "vendor/"; // POST

  //! Inventory items
  static const String getInventoryItems = BaseURL.CompleteURL + "product/";
}
