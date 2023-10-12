import 'dart:convert';
import 'dart:developer';

import 'package:pos/shop_manager/inventory/item_model.dart';
import 'package:pos/shop_manager/parties/partyModel.dart';
import 'package:pos/src/constants/constants.dart';

import './api.dart';
import 'package:http/http.dart' as http;

final String businessID = readData("userData")['businessId'].toString();

class APIServices {
  // Login
  static Future login(String email, password) async {
    Map _body = {"email": email, "password": password};
    log("Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.login),
        body: json.encode(_body),
        headers: BaseURL.header,
      );
      return res;
    } catch (e) {
      log("Exception@Login => $e");
    }
  }

  // Refresh token
  static Future getMyProfile() async {
    try {
      var res = await http.get(
        Uri.parse(ApiLink.getVendors + "${readData('userData')['id']}"),
        headers: BaseURL.authHeader,
      );
      return res;
    } catch (e) {
      log("EXCEPTION@MyProfile=> $e");
    }
  }

  static refreshToken() async {
    Map _body = {"refreshToken": readData('refreshToken')};
    log("Refresh Token Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.refreshToken),
        body: json.encode(_body),
        headers: BaseURL.header,
      );
      log("refreshing token status=>> [${res.statusCode}]");
      var _bodyData = json.decode(res.body);
      Map<String, String> _headerData = res.headers;
      if (res.statusCode == 201) {
        log("================== Success ================");
        // print('Date ==>> ${_headerData["date"]}');
        // writeData('date', _headerData['date']);
        print('Access Token ==>> ${_headerData["accesstoken"]}');
        writeData('accessToken', _headerData['accesstoken']);
        print('Refresh Token ==>> ${_headerData["refreshtoken"]}');
        writeData('refreshToken', _headerData['refreshtoken']);
        log("================== Success ==================");
        print(_bodyData.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

// Add new User
  static Future addNewUser(
    String name,
    String email,
    String role,
    String mobile,
    String password,
  ) async {
    Map _body = {
      "email": email,
      "mobile": mobile,
      "name": name,
      "password": password,
      "role": role,
    };
    log("Add user Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.addNewUser),
        body: json.encode(_body),
        headers: BaseURL.authHeader,
      );
      return res;
    } catch (e) {
      log("Exception@AddimgNewUser => $e");
    }
  }

  // verify via OTP
  static Future verifyOTP(String otp, String token) async {
    Map _body = {"otp": otp, "verifyToken": token};
    log("OTP Verification Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.verifyUserViaOTP),
        body: json.encode(_body),
        headers: BaseURL.header,
      );
      return res;
    } catch (e) {
      log("Exception@OTPVerification => $e");
    }
  }

  //? Get veendors list
  static
      // Future<List<Party>>
      getVendors() async {
    Uri uri = Uri.parse(ApiLink.getVendors + businessID);
    // log(uri.toString());
    try {
      log("Getting parties");
      var res = await http.get(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        // print("Party list : " + result.toString());
        log("Vendors => " + result.toString());
        // return result.map((e) => Party.fromJson(e)).toList();
        return result;
      } else if (res.statusCode == 403) {
        APIServices.refreshToken();
      } else {
        throw Exception('response not oke: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

//? get Customers
  static
      // Future<List<Party>>
      getCustomers() async {
    Uri uri = Uri.parse(ApiLink.getCustomers + businessID);
    // log(uri.toString());
    try {
      log("Getting parties");
      var res = await http.get(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        // print("Party list : " + result.toString());
        log("Customers => " + result.toString());
        // return result.map((e) => Party.fromJson(e)).toList();
        return result;
      } else {
        throw Exception('response not oke: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  //? Add Customer
  static Future addCustomer(
    String uuid,
    String name,
    String email,
    String mobile,
    String address,
  ) async {
    Map _body = {
      "uuid": uuid,
      "name": name,
      "email": email,
      "contact": mobile,
      "address": address,
    };
    log("Add Customer Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.addCustomer + businessID),
        body: json.encode(_body),
        headers: BaseURL.authHeader,
      );
      return res;
    } catch (e) {
      log("Exception@AddingCustomer => $e");
    }
  }

  //? Add Vendor
  static Future addVendor(
    String uuid,
    String supplierName,
    String supplierNumber,
    String businessName,
    String businessOwnerName,
    String businessAddress,
    String businessEmail,
    // String phone,
    String drugLicense,
    String gstNumber,
    // String panNumber,
    // String email,
  ) async {
    Map _body = {
      "uuid": uuid,
      "supplierName": supplierName,
      "supplierNumber": supplierNumber,
      "businessName": businessName,
      "businessOwner": businessOwnerName,
      "businessEmail": businessEmail,
      "businessAddress": businessAddress,
      // "contact": phone,
      "drugLicense": drugLicense,
      "gstNumber": gstNumber,
      // "website": "string"
    };

    log("Add Vendor Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.addVendor + businessID),
        body: json.encode(_body),
        headers: BaseURL.authHeader,
      );
      return res;
    } catch (e) {
      log("Exception@AddingVendor => $e");
    }
  }

  static
      // Future<List<InventoryItems>>
      getItems() async {
    Uri uri = Uri.parse(ApiLink.getInventoryItems + businessID);
    try {
      var res = await http.get(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        log('Items=>' + result.toString());
        // _list = result.map((e) => InventoryItems.fromJson(e)).toList();
        return result;
      } else {
        throw Exception('response not oke: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw e;
    }

    ///////
    //
  }
}
