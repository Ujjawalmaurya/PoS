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

  final TextEditingController searchController = TextEditingController();
  // Get controllers
  PartyController partyController = Get.find<PartyController>();
  InventoryController inventoryController = Get.find<InventoryController>();

  Rx<PaymentType> payType = Rx<PaymentType>(PaymentType.cash);

  RxDouble subTotal = 00.0.obs;
  RxDouble discount = 00.0.obs;
  RxDouble totalAmount = 00.0.obs;

  RxList<Map> itemsToBuy = <Map>[].obs;

  void convertToInvoiceItems() {
    // selectedItems will be converted into InvoiceItem-Class-objects
    List<InvoiceItem> selectedInvoiceItems = <InvoiceItem>[];

    selectedInvoiceItems = [];
    //
    for (var i = 0; i < selectedItems.length; i++) {
      // TO DO
      var _data = selectedItems[i];
      var item = InvoiceItem(
        itemName: _data['name'],
        quantity: _data['qty'],
        gst: _data['gst'],
        unitPrice: _data['rate'],
        expiryDate: DateTime(2030),
      );
      selectedInvoiceItems.add(item);
    }

    writeInvoice(selectedInvoiceItems);

    //
  }

  increaseQuantity(int index) {
    log(selectedItems.toString());
    // log("Increase in Qty ${selectedItems[index].quantity}");
    if (selectedItems[index]['qty'] >= 0) {
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
  void onClose() {
    //
    super.onClose();
  }

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
      subTotal.value += selectedItems[i]['rate'] * selectedItems[i]['qty'];
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
            // selectedItems.add({
            //   "name": item["name"],
            //   "price": item['price'],
            //   "gst": item['gst'],
            //   "qty": 1
            // }),
            calculatePrice(),
            // showQuickAlert("Item added", "${item.itemName} is added"),
          };
  }

  void removeFromSelectedItems(Map item) {
    selectedItems.contains(item)
        ? {
            selectedItems.remove(item),
            item['qty'] = 1,
            calculatePrice(),
          }
        : showSnackbar("Can't Delete", "Because item never added");
  }

  void writeInvoice(
    List<InvoiceItem> items,
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
      items: items,
    );

    // log(
    //   'Invoice Model: ${invoice.supplier.name}',
    //   time: DateTime.now(),
    // );

    // final pdfFile = await PDFInvoiceHelper.generate(invoice);
    // PdfApi.openFile(pdfFile);
    Get.to(() => PDFPreview(invoice: invoice));
  }
} // END

Map reqBody = {
  "active": true,
  "businessDetails": {"id": 0},
  "category": "General",
  "customer": {"id": 0},
  "id": 0,
  "invoiceNumber": "string",
  "orderItems": [
    {
      "amount": 0,
      "batch": "string",
      "cgst": 0,
      "discount": 0,
      "expiry": "2023-11-10T16:14:04.278Z",
      "hsn": 0,
      "id": 0,
      "mrp": 0,
      "name": "string",
      "pack": "string",
      "product": {"id": 0},
      "quantityChild": 0,
      "quantityParent": 0,
      "sgst": 0,
      "type": "TABLET"
    }
  ],
  "paymentDetail": {
    "currency": "INR", // const
    "notes": "string", // optional
    "paidAmount": "string", // in Paise
    "paymentOption": "UPI"
  },
  "roundOff": 0,
  "totalAmount": 0, // payable (paise)
  "totalAmountInWords": "string", // (optional )
  "totalDiscount": 0 // Rs
};
