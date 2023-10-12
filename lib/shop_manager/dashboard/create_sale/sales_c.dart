import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/lifecycle.dart';
import 'package:get/state_manager.dart';
import 'package:pos/pages/invoice/helper/pdf_helper.dart';
import 'package:pos/pages/invoice/helper/pdf_invoice_helper.dart';
import 'package:pos/pages/invoice/model/customer.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/pages/invoice/model/supplier.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class AddSalesController extends GetxController {
  RxBool isdiscountIsValue = false.obs;
  RxMap selectedCustomer = {}.obs;
  RxList<InvoiceItem> selectedItems = <InvoiceItem>[].obs;
  final TextEditingController searchController = TextEditingController();

  RxDouble subTotal = 00.0.obs;
  RxDouble discount = 00.0.obs;
  RxDouble totalAmount = 00.0.obs;

  List<Map> inventoryData = [
    {"name": "Apple cider", "price": 240.5, "gst": 10.0},
    {"name": "BenQ Monitor", "price": 56000.0, "gst": 28.0},
    {"name": "Lether belt", "price": 324.5, "gst": 18.0},
    {"name": "banana shake", "price": 300.0, "gst": 15.0},
    {"name": "Cup", "price": 49.0, "gst": 4.0},
    {"name": "Logitec Optical Mouse", "price": 3240.0, "gst": 34.0},
    {"name": "CosmicByte CB GK 03 Corona", "price": 2400.0, "gst": 22.0},
    {"name": "Apple53245234", "price": 32400.0, "gst": 34.0},
    {"name": "Vinegar", "price": 32.0, "gst": 4.0},
    {"name": "Frootieeeee", "price": 24.0, "gst": 14.0},
  ];

  List<Map> customers = [
    {'name': 'Ujjawal', 'age': '222', 'mob': '58455126322'},
    {'name': 'Sachin', 'age': '25', 'mob': '7520453245'},
    {'name': 'Shivmohan', 'age': '24', 'mob': '456242546'},
    {'name': 'Arpit', 'age': '22', 'mob': '424552752'},
    {'name': 'D J', 'age': '13', 'mob': '.4.240.42'},
  ];

  final Customer constCustomer = const Customer(
    name: 'Customer - Arpit Raj',
    address: 'a/0b, XYZ Street, Noida, WDC, Singapore',
    mob: '873581987320',
  );

  final Supplier constSupplier = const Supplier(
    name: 'Seller - Ujjawal Maurya',
    address: 'Prayagraj, Uttar Pradesh, India',
    upi: 'selleruid@okaxis',
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => super.onStart;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;
  //

  increaseDiscount() {
    // discount.value += (totalAmount / 100);
    Get.defaultDialog(
      title: "Add Discount",
      content: SwitchListTile(
        value: isdiscountIsValue.value,
        onChanged: (_va) {
          isdiscountIsValue.value = _va;
        },
        title: StatefulBuilder(
          builder: (context, setState) => TextField(
            decoration: InputDecoration(
              labelText: discount.toString(),
              helperText: "Dscount Rs/%",
              // label: Text("ASd"),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              discount.value = double.parse(val);
              calculatePrice();
            },
          ),
        ),
      ),
    );
  }

  void calculatePrice() {
    subTotal.value = 0;
    for (var i = 0; i < selectedItems.length; i++) {
      // TO DO
      subTotal.value += selectedItems[i].unitPrice;
      log(subTotal.value.toString());
    }
    totalAmount.value = subTotal.value - discount.value;
  }

  void addToSelectedItems(InvoiceItem item) {
    selectedItems.contains(item)
        ? showSnackbar("Item already added", 'item${item.itemName} is already added')
        : {
            selectedItems.add(item),
            calculatePrice(),
            // showQuickAlert("Item added", "${item.itemName} is added"),
          };
  }

  void removeFromSelectedItems(InvoiceItem item) {
    selectedItems.contains(item)
        ? {
            selectedItems.remove(item),
            calculatePrice(),
          }
        : showSnackbar("Can't Delete", "Because item never added");
  }

  void writeInvoice(
      // List<InvoiceItem> items, Customer customer, Supplier supplier
      ) async {
    final date = DateTime.now();
    final dueDate = date.add(
      const Duration(days: 7),
    );

    final invoice = Invoice(
      supplier: constSupplier,
      // customer: const Customer(
      //   name: 'Arpit',
      //   address: 'Civil Lines, Prayagraj - 211001',
      // ),
      customer: constCustomer,
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'Dummy Order Invoice (Testing purposes only)',
        number:
            'PPl-${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}',
      ),
      items: selectedItems,
    );

    final pdfFile = await PDFInvoiceHelper.generate(invoice);
    PdfApi.openFile(pdfFile);
  }
}// END