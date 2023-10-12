import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pos/shop_manager/parties/party_c.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

enum Type { customer, supplier }

class AddPartyController extends GetxController {
  final customerFormKey = GlobalKey<FormState>();
  final vendorFormKey = GlobalKey<FormState>();

  // Customer textediting controller
  final TextEditingController cName = TextEditingController(text: "Ujjawal Customerrr");
  final TextEditingController cNumber = TextEditingController(text: "6546585312");
  final TextEditingController cEmail = TextEditingController(text: "customerr@email.com");
  final TextEditingController cAddress =
      TextEditingController(text: "chamber 3/4, block U, B-homosphere, Marse, Milky way");
  // Vendors textediting controller
  final TextEditingController vName = TextEditingController();
  final TextEditingController vNumber = TextEditingController();
  final TextEditingController vBName = TextEditingController();
  final TextEditingController vBOwnerName = TextEditingController();
  final TextEditingController vBAddress = TextEditingController();
  final TextEditingController vBEmail = TextEditingController();
  // final TextEditingController vBNumber = TextEditingController();
  final TextEditingController vDrugLicense = TextEditingController();
  final TextEditingController vGST = TextEditingController();
  // final TextEditingController vPAN = TextEditingController();
  // final TextEditingController vName = TextEditingController();
  // final TextEditingController vName = TextEditingController();

// PartyController
  PartyController partyController = Get.find<PartyController>();

  bool isCustomer = true;
  Type partyType = Type.customer;

  updatePartyType(Set<Type> _val) {
    partyType = _val.first;
    update();
  }

  addCustomer() async {
    var _res = await APIServices.addCustomer(
      Utils.getUUID(),
      cName.text,
      cEmail.text,
      cNumber.text,
      cAddress.text,
    );

    var response = jsonDecode(_res.body);
    log("RES=> $response");

    showSnackbar('Response', response.toString());
    partyController.getCustomers();
  }

  addVendor() async {
    var _res = await APIServices.addVendor(
      Utils.getUUID(),
      // vendor
      vName.text,
      vNumber.text,
      // Business
      vBName.text,
      vBOwnerName.text,
      vBAddress.text,
      vBEmail.text,
      // vBNumber.text,
      vDrugLicense.text,
      vGST.text,
    );
    var response = jsonDecode(_res.body);
    showSnackbar("Response", response.toString());
    partyController.getVendors();
  }
} // END