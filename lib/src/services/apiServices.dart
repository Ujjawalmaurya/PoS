import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:pos/shop_manager/navbar_c.dart';
import 'package:pos/shop_manager/parties/add_party/vendor_model.dart';
import 'package:pos/shop_manager/parties/customer_model.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

import './api.dart';
import 'package:http/http.dart' as http;

final String businessID = readData(StorageKey.user.userData)['businessId'].toString();
UserController userController = Get.find<UserController>();

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
        Uri.parse(ApiLink.getVendors + "${readData(StorageKey.user.userData)['id']}"),
        headers: BaseURL.authHeader,
      );
      return res;
    } catch (e) {
      log("EXCEPTION@MyProfile=> $e");
    }
  }

  static refreshAccessToken(reCallFunction) async {
    Map _body = {"refreshToken": userController.refreshToken};
    log("Refresh Token Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.refreshAccessTokenLink),
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
        writeData(StorageKey.user.accessToken, _headerData['accesstoken']);
        userController.accessToken = _headerData['accesstoken'] ?? ''; // updateData in controller
        print('Refresh Token ==>> ${_headerData["refreshtoken"]}');
        userController.refreshToken = _headerData['refreshtoken'] ?? ''; // updateData in controller
        writeData(StorageKey.user.refreshToken, _headerData['refreshtoken']);
        log("================== Success ==================");
        print(_bodyData.toString());
        // reCallFunction;
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

  //? Get vendors list
  static Future<List<Vendor>> getVendors() async {
    Uri uri = Uri.parse(ApiLink.getVendors + businessID);
    // log(uri.toString());
    try {
      log("Getting parties");
      var res = await http.get(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        // print("Party list : " + result.toString());
        print("Vendors => " + result.toString());
        return result.map((e) => Vendor.fromJson(e)).toList();
        // return result;
        // } else if (res.statusCode == 403) {
        //   APIServices.refreshToken();
      } else {
        throw Exception('response not oke: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

//? get Customers

  static Future<List<Customer>> getCustomers() async {
    Uri uri = Uri.parse(ApiLink.getCustomers + businessID);
    // log(uri.toString());
    try {
      log("Getting parties");
      var res = await http.get(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        final List result = json.decode(res.body);
        // print("Party list : " + result.toString());
        print("Customers => " + result.toString());
        return result.map((e) => Customer.fromJson(e)).toList();
        // return result;
      } else if (res.statusCode == 403) {
        return refreshAccessToken(getCustomers());
      } else {
        throw Exception('Getting customers=> response not oke: res:${res.statusCode}');
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

  static deleteCustomer(String customerID) async {
    Uri uri = Uri.parse(ApiLink.deleteCustomer + customerID + "/$businessID");
    try {
      var res = await http.delete(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        showSnackbar("Succeed", "Deleted successfully");
      } else {
        throw Exception('response not oke while deleting: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  static deleteSupplier(String supplierID) async {
    Uri uri = Uri.parse(ApiLink.deleteVendor + supplierID + "/$businessID");
    try {
      var res = await http.delete(uri, headers: BaseURL.authHeader);
      if (res.statusCode == 200) {
        showSnackbar("Succeed", "Deleted successfully");
      } else {
        throw Exception('response not oke while deleting: res:${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      throw e;
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

  //? Add Vendor
  static Future addItem() async {
    Map _body = {
      "batchNum": "SD7DF8C",
      "category": "General",
      "cd": 2,
      "cgst": 5,
      "discQty": 5,
      "discountPerProduct": 2,
      "hsn": 4342,
      "id": 3,
      "loc": "LOC",
      "manufacturer": "LOC_manufacturer",
      "mrp": 300,
      "name": "Dummy name",
      "quantityChild": 3,
      "quantityMax": 6,
      "quantityParent": 10,
      "rate": 300,
      "sgst": 5,
      "subCategory": "dummySubCategory",
      "td": 23,
      "totalAmount": 3000,
      "type": "TABLET",
      "unit": "string",
      "vendorId": 2
    };

    log("Add item Req-Body=>> $_body ");
    try {
      var res = await http.post(
        Uri.parse(ApiLink.addInventoryItem + businessID),
        body: json.encode(_body),
        headers: BaseURL.authHeader,
      );
      final _data = json.decode(res.body);
      log(_data.toString());
      log(res.statusCode.toString());
      return res;
    } catch (e) {
      log("Exception@AddingItem => $e");
    }
  }
}
