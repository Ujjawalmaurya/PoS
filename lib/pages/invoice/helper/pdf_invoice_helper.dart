import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pos/pages/dashboard/create_sale/sales_c.dart';
import 'package:pos/pages/parties/customer_model.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';

import '../../../src/utils/utils.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import 'pdf_helper.dart';

AddSalesController salesController = Get.find<AddSalesController>();

class Invoices {
  static Future<Uint8List> purchase(Invoice invoice) async {
    // log("Invoice Data ${invoice}");
    final pdf = pw.Document(
      title: " ",
      author: "seller",
    );
    pdf.addPage(
      pw.MultiPage(
        pageFormat: readData(StorageKey.settings.isInvoiceLandscape) ?? false
            ? PdfPageFormat.a4.landscape
            : PdfPageFormat.a4.portrait,
        orientation: readData(StorageKey.settings.isInvoiceLandscape) ?? false
            ? PageOrientation.landscape
            : PageOrientation.portrait,
        // ? Theme
        theme: pw.ThemeData(
            bulletStyle: const pw.TextStyle(
              color: PdfColors.grey800,
            ),
            paragraphStyle: const TextStyle(
              wordSpacing: 0.2,
              letterSpacing: 0.1,
              background: BoxDecoration(
                color: PdfColors.grey200,
              ),
            )
            // maxLines: 1,
            ),
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        header: (context) => Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Paperlessly invoice",
                style: const TextStyle(
                  color: PdfColors.grey500,
                ),
              ),
              Text(
                "Sales Invoice",
                style: TextStyle(
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Customer copy",
                style: const TextStyle(
                  color: PdfColors.grey500,
                ),
              ),
            ],
          ),
        ),
        build: (context) => [
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          // buildHeader(invoice),
          Elements.buildTitle(invoice),
          Elements.buildTable(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Elements.buildInvoice(invoice),
          // Divider(),
          // Elements.buildTotal(invoice), //? Not in purchase
          // Paragraph(text: LoremText().paragraph(60)),
        ],
        footer: (context) => Elements.buildFooter(invoice),
      ),
    );

    // return PdfApi.saveDocument(name: 'paperlessly-invoice.pdf', pdf: pdf);
    return pdf.save();
  }

  static Future<Uint8List> sale(Invoice invoice) async {
    // log("Invoice Data ${invoice}");
    final pdf = pw.Document(
      title: "GoPaperLess",
      author: "seller",
    );
    pdf.addPage(
      pw.MultiPage(
        pageFormat: readData(StorageKey.settings.isInvoiceLandscape) ?? false
            ? PdfPageFormat.a4.landscape
            : PdfPageFormat.a4.portrait,
        orientation: readData(StorageKey.settings.isInvoiceLandscape) ?? false
            ? PageOrientation.landscape
            : PageOrientation.portrait,
        // ? Theme
        theme: pw.ThemeData(
            bulletStyle: const pw.TextStyle(
              color: PdfColors.grey800,
            ),
            paragraphStyle: const TextStyle(
              wordSpacing: 0.2,
              letterSpacing: 0.1,
              background: BoxDecoration(
                color: PdfColors.grey200,
              ),
            )
            // maxLines: 1,
            ),
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        header: (context) => Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Paperlessly invoice",
                style: const TextStyle(
                  color: PdfColors.grey500,
                ),
              ),
              Text(
                "Sales Invoice",
                style: TextStyle(
                  color: PdfColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Customer copy",
                style: const TextStyle(
                  color: PdfColors.grey500,
                ),
              ),
            ],
          ),
        ),
        build: (context) => [
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          // buildHeader(invoice),
          Elements.buildTitle(invoice),
          Elements.buildTable(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Elements.buildInvoice(invoice),
          Divider(),
          Elements.buildTotal(invoice),
          // Paragraph(text: LoremText().paragraph(60)),
        ],
        footer: (context) => Elements.buildFooter(invoice),
      ),
    );

    // return PdfApi.saveDocument(name: 'paperlessly-invoice.pdf', pdf: pdf);
    return pdf.save();
  }
}

class Elements {
  // Elements ===========================================================================================

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildSupplierAddress(invoice.supplier),
              // if (readData('showInvoiceQR') ?? false)
              //   Container(
              //     height: 25,
              //     width: 25,
              //     child: BarcodeWidget(
              //       barcode: Barcode.qrCode(),
              //       data: invoice.info.number,
              //     ),
              //   ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(invoice.customer),
              // buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Container(
        // width: ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer: ${customer.name}", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Contact: ${customer.contact}"),
            // Text("Address: ${customer.address}"),
          ],
        ),
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:', 'Invoice Date:',
      // 'Payment Terms:',
      'Due Date:',
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      // paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  // static Widget buildSupplierAddress(Supplier supplier) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           supplier.name,
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         if (readData('showShopAdd') ?? false) Text(supplier.address),
  //       ],
  //     );

  static Widget buildTitle(Invoice invoice) => Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              // 'Paperlessly Outlet One(1)',
              readData(StorageKey.user.userData)['businessname'] ?? "Some business name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 0.6 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          // SizedBox(height: 0.6 * PdfPageFormat.cm),
        ],
      );

  static Widget buildTable(invoice) {
    // final paymentTerms = '${invoice.info.dueDate.difference(invoice.info.date).inDays} days';
    // final titles = <String>['Invoice Number:', 'Invoice Date:', 'Payment Terms:', 'Due Date:'];
    // final data = <String>[
    //   invoice.info.number,
    //   Utils.formatDate(invoice.info.date),
    //   paymentTerms,
    //   Utils.formatDate(invoice.info.dueDate),
    // ];
    return Table(
      // border: TableBorder.all(width: 0.1),
      children: [
        TableRow(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.supplier.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1 * PdfPageFormat.mm),
                if (readData(StorageKey.settings.showShopAdd) ?? false) Text(invoice.supplier.address),
              ],
            ),
            if (readData(StorageKey.settings.showInvoiceQR) ?? false)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  width: 40,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.info.number,
                  ),
                ),
              ),
          ],
        ),
        TableRow(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Customer: ${invoice.customer.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Contact: ${invoice.customer.contact}"),
                Text("Address: ${invoice.customer.address}"),
              ],
            ),
            buildInvoiceInfo(invoice.info),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: List.generate(
            //     invoice.info.titles.length,
            //     (index) {
            //       final title = titles[index];
            //       final value = data[index];

            //       return buildText(title: title, value: value, width: 200);
            //     },
            //   ),
            // )
          ],
        ),
      ],
    );
  }

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Sr',
      'Item',
      'Qty',
      'Expiry',
      'Batch',
      'HSN',
      // if (!readData(StorageKey.hideGSTperItem)) 'GST(CGST+SGST)%',
      'MRP',
      'disc',
      'Total(Rs)',
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity;

      return [
        '${invoice.items.indexOf(item) + 1}',
        item.itemName,
        '${item.quantity}',
        Utils.formatDate(item.expiryDate).toString(),
        'XYZ97ABC',
        'HSN00',
        // if (!readData(StorageKey.hideGSTperItem)) '${item.gst}(${item.gst / 2} + ${item.gst / 2})%',
        "${item.unitPrice}",
        '00',
        Utils.parseInRs(total),
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      // border: null,
      border: TableBorder.all(width: 0.5),

      rowDecoration: const BoxDecoration(color: PdfColors.white),
      oddRowDecoration: const BoxDecoration(color: PdfColors.grey100),
      cellStyle: const TextStyle(fontSize: 9),
      headerStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      // cellHeight: 1,
      cellPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      cellAlignments: {
        0: Alignment.center, //
        1: Alignment.centerLeft, //
        2: Alignment.center, //
        3: Alignment.centerRight, //
        4: Alignment.centerRight, //
        5: Alignment.centerRight, //
        6: Alignment.centerRight, //
        // 8: Alignment.centerRight, //
        7: Alignment.centerRight, //
        8: Alignment.centerRight, //
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal =
        invoice.items.map((item) => item.unitPrice * item.quantity).reduce((item1, item2) => item1 + item2);
    final gstPercent = invoice.items.first.gst;
    final gst = netTotal * (gstPercent / 100);
    final total = netTotal - salesController.discount.value;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bullet(
                  text: LoremText().paragraph(20),
                  // padding: EdgeInsets.all(5),
                  style: const TextStyle(fontSize: 10),
                ),
                // Paragraph(
                //   textAlign: TextAlign.left,
                //   text: LoremText().paragraph(8),
                // ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  // value: "$netTotal Rs",
                  value: Utils.parseInRs(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'GST $gstPercent%',
                  // value: "$gst Rs",
                  value: Utils.parseInRs(gst),
                  unite: true,
                ),
                buildText(
                  title: 'Discount',
                  value: "- ${salesController.discount} Rs",
                  unite: true,
                ),
                // buildText(
                //   title: 'Payment Method',
                //   value: "${salesController.payType}",
                //   unite: true,
                // ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.parseInRs(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                buildText(title: 'Payment Method', value: "${salesController.payType}")
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if (readData(StorageKey.settings.showShopUPI) ?? false)
            buildSimpleText(title: 'UPI', value: invoice.supplier.upi),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
