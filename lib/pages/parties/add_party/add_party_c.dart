import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/parties/party_c.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

enum Type { customer, supplier }

class AddPartyController extends GetxController {
  final customerFormKey = GlobalKey<FormState>();
  final vendorFormKey = GlobalKey<FormState>();

  //! Customer textediting controller
  final TextEditingController cName = TextEditingController(
      // text: "Dummy Customerrr",
      );
  final TextEditingController cNumber = TextEditingController(
      // text: "6354658312",
      );
  final TextEditingController cEmail = TextEditingController(
      // text: "customerr@email.com",
      );
  final TextEditingController cAddress = TextEditingController(
      // text: "chamber 3/4, block U, B-homosphere, Marse, Milky way",
      );

  //! Vendors text editing controller
  final TextEditingController vName = TextEditingController(
      // text: "Supplier Unknown",
      );
  final TextEditingController vNumber = TextEditingController(
      // text: "9999999999",
      );
  final TextEditingController vBName = TextEditingController(
      // text: "Business UnKnown",
      );
  final TextEditingController vBOwnerName = TextEditingController(
      // text: "Own-er UnKnown",
      );
  final TextEditingController vBAddress = TextEditingController(
      // text: "Add-ress Un-Known",
      );
  final TextEditingController vBEmail = TextEditingController(
      // text: "DummyData@email.co",
      );
  final TextEditingController vDrugLicense = TextEditingController(
      // text: "D3u2m2my4Da5ta0",
      );
  final TextEditingController vGST = TextEditingController(
      // text: "D2u4mm5y2D4at5a0",
      );
  // final TextEditingController vPAN = TextEditingController();

//! PartyController
  PartyController partyController = Get.find<PartyController>();

  bool isCustomer = true;
  Type partyType = Type.customer;

  updatePartyType(Set<Type> _val) {
    partyType = _val.first;
    update();
  }

// ! Add customer

  void addCustomer() async {
    var _res = await APIServices.addCustomer(
      Utils.getUUID(),
      cName.text,
      cEmail.text,
      cNumber.text,
      cAddress.text,
    );

    if (_res.statusCode == 201) {
      Snackbar.success("Customer added", "${cName.text} added successfully");
      cName.clear();
      cEmail.clear();
      cNumber.clear();
      cAddress.clear();
    } else {
      Snackbar.failed("Failed", "Failed to add ${cName.text}");
    }

    var response = jsonDecode(_res.body);
    log("RES=> $response");
    partyController.getCustomers();
  }

  //! Add vendor

  void addVendor() async {
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
    if (_res.statusCode == 201) {
      Snackbar.success("Vendor Added Successfully", "${vName.text} added successfully");
      vName.clear();
      vNumber.clear();
      vBName.clear();
      vBOwnerName.clear();
      vBAddress.clear();
      vBEmail.clear();
      vDrugLicense.clear();
      vGST.clear();
    } else {
      Snackbar.failed("Error", "${vName.text} was not added");
    }
    // Snackbar.quickAlert("Response", response.toString());
    partyController.getVendors();
  }
} // END