import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/pages/invoice/model/supplier.dart';
import 'package:pos/pages/invoice/pdf_printing.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/parties/customer_model.dart';
import 'package:pos/pages/parties/party_c.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/utils/storage_keys.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

enum PaymentType { CASH, UPI, CARD }

class AddSalesController extends GetxController {
  RxBool finalDiscountType_isValue = true.obs;
  var selectedCustomer = Rxn<Customer>();
  RxList selectedItems = [].obs; // all selected items (cart items)

  final TextEditingController searchController = TextEditingController();
  // Get controllers
  PartyController partyController = Get.find<PartyController>();
  InventoryController inventoryController = Get.find<InventoryController>();

  Rx<PaymentType> payType = Rx<PaymentType>(PaymentType.CASH);

  RxDouble subTotal = 00.0.obs;
  RxDouble discount = 00.0.obs;
  RxDouble totalAmount = 00.0.obs;

  // RxList<Map> itemsToBuy = <Map>[].obs;

  // void convertToInvoiceItems() {
  //   // selectedItems will be converted into InvoiceItem-Class-objects
  //   List<InvoiceItem> selectedInvoiceItems = <InvoiceItem>[];

  //   selectedInvoiceItems = [];
  //   //
  //   for (var i = 0; i < selectedItems.length; i++) {
  //     // TO DO
  //     var _data = selectedItems[i];
  //     var item = InvoiceItem(
  //       itemName: _data['name'],
  //       quantity: _data['qty'],
  //       // gst: _data['gst'],
  //       gst: 18,
  //       unitPrice: _data['mrp'],
  //       expiryDate: DateTime(2030),
  //     );
  //     selectedInvoiceItems.add(item);
  //   }

  //   writeInvoice(selectedInvoiceItems);

  //   //
  // }

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

  // final Supplier constSupplier = const Supplier(
  //   name: 'Seller - Ujjawal Maurya',
  //   address: 'Prayagraj, Uttar Pradesh, India',
  //   upi: 'selleruid@okaxis',
  // );

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
      subTotal.value += selectedItems[i]['mrp'] * selectedItems[i]['qty'];
      log("Subtotal: ${subTotal.value}");
    }
    totalAmount.value = subTotal.value - discount.value;
  }

  void addToSelectedItems(Map item) {
    selectedItems.contains(item)
        // ? Snackbar.trigger("Item already added", 'item${item["itemName"]} is already added')
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
        : Snackbar.trigger("Can't Delete", "Because item never added");
  }

  ///
  void addSale() {
    //
    Map reqBody = {
      "active": true,
      "businessDetails": {"id": readData(StorageKey.user.userData)['businessId'].toString()},
      "category": "Pharma",
      "customer": {"id": selectedCustomer.value!.id},
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
        "paidAmount": totalAmount.value * 100, // in Paise
        "paymentOption": payType.value != PaymentType.CARD
            ? payType.value == PaymentType.CASH
                ? "CASH"
                : "UPI"
            : "CARD",
      },
      "roundOff": 0,
      "totalAmount": totalAmount.value * 100, // payable (paise)
      "totalAmountInWords": "string", // (optional )
      "totalDiscount": discount.value // Rs
    };
    var res = APIServices.createSale(reqBody);
    log(res.toString());
  }

  // void writeInvoice(Map data) async {
  //   final date = DateTime.now();
  //   final dueDate = date.add(const Duration(days: 7));

  //   final Map invoice = {
  //     // supplier: constSupplier,
  //     "supplier": data[''],
  //     "customer": {
  //       "name": selectedCustomer.value!.name,
  //       "uuid": selectedCustomer.value!.uuid,
  //       "contact": selectedCustomer.value!.contact,
  //       "address": selectedCustomer.value!.address,
  //       "email": selectedCustomer.value!.email,
  //     },
  //     "info": InvoiceInfo(
  //       date: date,
  //       dueDate: dueDate,
  //       description: description,
  //       number: invoiceNo,
  //     ),
  //     "items": items,
  //   };
  //   Get.to(() => PDFPreview(invoice: invoice));
  // }

// ==> Write Invoice Backup <==
  void writeInvoice(
    List<InvoiceItem> items,
    Customer customer,
    Supplier supplier,
    String invoiceNo,
    String description,
  ) async {
    final date = DateTime.now();
    final dueDate = date.add(
      const Duration(days: 7),
    );

    final invoice = Invoice(
      // supplier: constSupplier,
      supplier: supplier,
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
        description: description,
        number: invoiceNo,
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

// ? Sale Items backup
// "orderItems": [
//         {
//           "amount": 0,
//           "batch": "string",
//           "cgst": 0,
//           "discount": 0,
//           "expiry": "2023-11-10T16:14:04.278Z",
//           "hsn": 0,
//           "id": 0,
//           "mrp": 0,
//           "name": "string",
//           "pack": "string",
//           "product": {"id": 0},
//           "quantityChild": 0,
//           "quantityParent": 0,
//           "sgst": 0,
//           "type": "TABLET"
//         }
//       ],



// ==> Write Invoice Backup <==
  // void writeInvoice(
  //   List<InvoiceItem> items,
  //   Customer customer,
  //   Supplier supplier,
  //   String invoiceNo,
  //   String description,
  // ) async {
  //   final date = DateTime.now();
  //   final dueDate = date.add(
  //     const Duration(days: 7),
  //   );

  //   final invoice = Invoice(
  //     // supplier: constSupplier,
  //     supplier: supplier,
  //     customer: Customer(
  //       id: selectedCustomer.value!.id,
  //       name: selectedCustomer.value!.name,
  //       uuid: selectedCustomer.value!.uuid,
  //       contact: selectedCustomer.value!.contact,
  //       address: selectedCustomer.value!.address,
  //       email: selectedCustomer.value!.email,
  //     ),
  //     info: InvoiceInfo(
  //       date: date,
  //       dueDate: dueDate,
  //       description: description,
  //       number: invoiceNo,
  //     ),
  //     items: items,
  //   );

  //   // log(
  //   //   'Invoice Model: ${invoice.supplier.name}',
  //   //   time: DateTime.now(),
  //   // );

  //   // final pdfFile = await PDFInvoiceHelper.generate(invoice);
  //   // PdfApi.openFile(pdfFile);
  //   Get.to(() => PDFPreview(invoice: invoice));
  // }