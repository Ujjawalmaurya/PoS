import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/add_party/vendor_model.dart';
import 'package:pos/shop_manager/parties/customer_model.dart';
import 'package:pos/src/services/apiServices.dart';

enum Type { customer, supplier }

class PartyController extends GetxController {
  Type partyType = Type.customer;

  // RxList<Party> parties = <Party>[].obs;

  List<Customer> customers = [];
  List<Vendor> vendors = [];

  @override
  void onInit() async {
    getCustomers();
    getVendors();
    super.onInit();
  }

  void getCustomers() async {
    customers = await APIServices.getCustomers();
    print(customers.toString());
    update();
  }

  void getVendors() async {
    vendors = await APIServices.getVendors();
    print(vendors.toString());
    update();
  }

  updatePartyType(Set<Type> _val) {
    partyType = _val.first;
    update();
  }

  Future showCustomerInfo(Customer customerInfo) {
    return Get.defaultDialog(
      title: customerInfo.name.toString(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Contact: ${customerInfo.contact}"),
          Text("Email: ${customerInfo.email}"),
          Text("Address: ${customerInfo.address}"),
        ],
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      actions: [
        OutlinedButton(
          onPressed: () {},
          child: const Text("Update Customer"),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          onPressed: () {
            Get.back();
            APIServices.deleteCustomer(customerInfo.id.toString());
            getCustomers();
          },
          child: const Text("Delete Customer"),
        ),
      ],
    );
    // {id: 2, uuid: 0abd0730-5183-11ee-ac01-010d0cb905f6,
    //name: Ujjawal Customerrr,
    //contact: 6546585312,
    //email: customerr@email.com,
    //address: chamber 3/4, block U, B-homosphere, Marse, Milky way}
  }

  Future showVendorInfo(Vendor vendorInfo) {
    // {id: 2, uuid: 9a59e9d0-5188-11ee-b79f-2fa5c39099bb,
    //supplierName: supplier 2,
    //supplierNumber: 1212121212,
    //businessName: local business,
    //businessOwner: random name,
    //businessEmail: dummy@random.email,
    //businessAddress: random dummy address,
    //gstNumber: 1AS6D5F65SF325DS,
    //drugLicense: sad1f2ASDFdd,
    //contact: null, website: null, }

    return Get.defaultDialog(
      title: "Supplier Details",
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Chip(label: Text("Supplier")),
          Text("Name: ${vendorInfo.supplierName}"),
          Text("Contact: ${vendorInfo.supplierNumber}"),
          const Chip(label: Text("Business")),
          Text("Name: ${vendorInfo.businessName}"),
          Text("Owner: ${vendorInfo.businessOwner}"),
          Text("Email: ${vendorInfo.businessEmail}"),
          Text("Address: ${vendorInfo.businessAddress}"),
          Text("GST Number: ${vendorInfo.gstNumber}"),
          Text("Drug License: ${vendorInfo.drugLicense}"),
        ],
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      actions: [
        OutlinedButton(
          onPressed: () {},
          child: const Text("Update Supplier"),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          onPressed: () {
            Get.back();
            APIServices.deleteSupplier(vendorInfo.id.toString());
            getVendors();
          },
          child: const Text("Delete Supplier"),
        ),
      ],
    );
  }
} //
