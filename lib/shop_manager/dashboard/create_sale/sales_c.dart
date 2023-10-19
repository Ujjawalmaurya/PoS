import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/pages/invoice/model/supplier.dart';
import 'package:pos/pages/invoice/preview.dart';
import 'package:pos/shop_manager/inventory/inventory_c.dart';
import 'package:pos/shop_manager/parties/customer_model.dart';
import 'package:pos/shop_manager/parties/party_c.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

enum PaymentType { cash, upi, card }

class AddSalesController extends GetxController {
  RxBool finalDiscountType_isValue = false.obs;
  final selectedCustomer = Rxn<Customer>();
  RxList selectedItems = [].obs;
  RxList<InvoiceItem> selectedInvoiceItems =
      <InvoiceItem>[].obs; // selectedItems will be converted into InvoiceItem
  final TextEditingController searchController = TextEditingController();
  // Get controllers
  PartyController partyController = Get.find<PartyController>();
  InventoryController inventoryController = Get.find<InventoryController>();

  Rx<PaymentType> payType = Rx<PaymentType>(PaymentType.cash);

  RxDouble subTotal = 00.0.obs;
  RxDouble discount = 00.0.obs;
  RxDouble totalAmount = 00.0.obs;

  RxList<Map> inventoryData = [
    {"name": "Apple cider", "price": 240.5, "gst": 10.0, "qty": 2},
    {"name": "BenQ Monitor", "price": 56000.0, "gst": 28.0, "qty": 1},
    {"name": "Lether belt", "price": 324.5, "gst": 18.0, "qty": 1},
    {"name": "banana shake", "price": 300.0, "gst": 15.0, "qty": 1},
    {"name": "Cup", "price": 49.0, "gst": 4.0, "qty": 1},
    {"name": "Logitec Optical Mouse", "price": 3240.0, "gst": 34.0, "qty": 1},
    {"name": "CosmicByte CB GK 03 Corona", "price": 2400.0, "gst": 22.0, "qty": 1},
    {"name": "Apple53245234", "price": 32400.0, "gst": 34.0, "qty": 1},
    {"name": "Vinegar", "price": 32.0, "gst": 4.0, "qty": 1},
    {"name": "Frootieeeee", "price": 24.0, "gst": 14.0, "qty": 1},
  ].obs;

  // List<Map> customers = [
  //   {'name': 'Ujjawal', 'age': '222', 'mob': '58455126322'},
  //   {'name': 'Sachin', 'age': '25', 'mob': '7520453245'},
  //   {'name': 'Shivmohan', 'age': '24', 'mob': '456242546'},
  //   {'name': 'Arpit', 'age': '22', 'mob': '424552752'},
  //   {'name': 'D J', 'age': '13', 'mob': '.4.240.42'},
  // ];

  void convertToInvoiceItems() {
    selectedInvoiceItems.value = [];
    //
    for (var i = 0; i < selectedItems.length; i++) {
      // TO DO
      var _data = selectedItems[i];
      var item = InvoiceItem(
        itemName: _data['name'],
        quantity: _data['qty'],
        gst: _data['gst'],
        unitPrice: _data['price'],
        expiryDate: DateTime(2030),
      );
      selectedInvoiceItems.add(item);
    }

    writeInvoice();

    //
  }

  increaseQuantity(int index) {
    log(selectedItems.toString());
    // log("Increase in Qty ${selectedItems[index].quantity}");
    if (selectedItems[index]['qty'] >= 1) {
      selectedItems[index]['qty']++;
      calculatePrice();
      update();
    }
  }

  decreaseQuantity(int index) {
    log(selectedItems.toString());
    // log("Decrease in Qty${selectedItems[index].quantity}");
    if (selectedItems[index]['qty'] > 1) {
      selectedItems[index]['qty']--;
      calculatePrice();
      update();
    }
  }

  // final Customer constCustomer = Customer(
  //   name: 'Customer - Arpit Raj',
  //   address: 'a/0b, XYZ Street, Noida, WDC, Singapore',
  //   contact: '873581987320',
  // );

  final Supplier constSupplier = const Supplier(
    name: 'Seller - Ujjawal Maurya',
    address: 'Prayagraj, Uttar Pradesh, India',
    upi: 'selleruid@okaxis',
  );

  @override
  void onInit() {
    selectedCustomer.value = Customer();
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

  updateDiscount() {
    // discount.value += (totalAmount / 100);
    Get.defaultDialog(
      title: "Add Discount",
      content: TextField(
        decoration: InputDecoration(
          labelText: "Discount in ${finalDiscountType_isValue.value ? "Rs" : "%"}",
          helperText: "Discount amount will be deducted",
          // label: Text("ASd"),
        ),
        keyboardType: TextInputType.number,
        onChanged: (val) {
          discount.value = double.parse(val);
          calculatePrice();
        },
      ),
    );
  }

  void calculatePrice() {
    subTotal.value = 0;
    for (var i = 0; i < selectedItems.length; i++) {
      // TO DO
      subTotal.value += selectedItems[i]['price'] * selectedItems[i]['qty'];
      log("Subtotal: ${subTotal.value}");
    }
    totalAmount.value = subTotal.value - discount.value;
  }

  void addToSelectedItems(Map item) {
    selectedItems.contains(item)
        // ? showSnackbar("Item already added", 'item${item["itemName"]} is already added')
        ? increaseQuantity(selectedItems.indexOf(item))
        : {
            selectedItems.add(item),
            calculatePrice(),
            // showQuickAlert("Item added", "${item.itemName} is added"),
          };
  }

  void removeFromSelectedItems(Map item) {
    selectedItems.contains(item)
        ? {
            selectedItems.remove(item),
            calculatePrice(),
          }
        : showSnackbar("Can't Delete", "Because item never added");
  }

  void writeInvoice(
      // List<InvoiceItem> items,
      // Customer customer,
      // Supplier supplier
      ) async {
    final date = DateTime.now();
    final dueDate = date.add(
      const Duration(days: 7),
    );

    final invoice = Invoice(
      supplier: constSupplier,
      customer: Customer(
        id: selectedCustomer.value!.id,
        name: selectedCustomer.value!.name,
        uuid: selectedCustomer.value!.uuid,
        contact: selectedCustomer.value!.contact,
        address: selectedCustomer.value!.address,
        email: selectedCustomer.value!.email,
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'Dummy Order Invoice (Testing purposes only)',
        number:
            'PPl_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().millisecond}',
      ),
      items: selectedInvoiceItems,
    );

    // log(
    //   'Invoice Model: ${invoice.supplier.name}',
    //   time: DateTime.now(),
    // );

    // final pdfFile = await PDFInvoiceHelper.generate(invoice);
    // PdfApi.openFile(pdfFile);
    Get.to(() => PDFPreview(invoice: invoice));
  }
}// END