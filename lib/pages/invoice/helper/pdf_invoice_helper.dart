import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';
import 'package:pos/shop_manager/parties/customer_model.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';

import '../../../src/utils/utils.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import 'pdf_helper.dart';

AddSalesController salesController = Get.find<AddSalesController>();

class PDFInvoiceHelper {
  static Future<File> generate(Invoice invoice) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData(
          bulletStyle: const pw.TextStyle(color: PdfColors.grey900),
        ),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                "Customer copy",
                style: const TextStyle(
                  color: PdfColors.grey500,
                ),
              ),
            ],
          ),
        ),
        pageFormat:
            salesController.isLandscape.value ? PdfPageFormat.a4.landscape : PdfPageFormat.a4.portrait,
        orientation: salesController.isLandscape.value ? PageOrientation.landscape : PageOrientation.portrait,
        build: (context) => [
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          // buildHeader(invoice),
          buildTable(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTitle(invoice),
          buildInvoice(invoice),
          Divider(),
          buildTotal(invoice),
          // Paragraph(text: LoremText().paragraph(60)),
        ],
        footer: (context) => buildFooter(invoice),
      ),
    );

    return PdfApi.saveDocument(name: 'paperlessly-invoice.pdf', pdf: pdf);
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // 'Paperlessly Outlet One(1)',
            readData(StorageKey.userData)['businessname'] ?? "Some business name",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                if (readData(StorageKey.showShopAdd) ?? false) Text(invoice.supplier.address),
              ],
            ),
            if (readData(StorageKey.showInvoiceQR) ?? false)
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
      'MRP',
      'Batch',
      'HSN',
      // if (!readData(StorageKey.hideGSTperItem)) 'GST(CGST+SGST)%',
      'disc',
      'Total (Rs)',
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + (item.gst / 100));

      return [
        '${invoice.items.indexOf(item) + 1}',
        item.itemName,
        '${item.quantity}',
        Utils.formatDate(item.expiryDate).toString(),
        'Rs ${item.unitPrice}',
        'XYZ97ABC',
        'HSN00',
        // if (!readData(StorageKey.hideGSTperItem)) '${item.gst}(${item.gst / 2} + ${item.gst / 2})%',
        '00',
        'Rs ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      // border: null,
      border: TableBorder.all(width: 0.5),

      rowDecoration: const BoxDecoration(color: PdfColors.white),
      oddRowDecoration: const BoxDecoration(color: PdfColors.grey100),
      cellStyle: const TextStyle(fontSize: 7),
      headerStyle: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
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
    final total = netTotal + (gst / 100);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              children: [
                Bullet(
                  text: LoremText().paragraph(8),
                  // padding: EdgeInsets.all(5),
                  style: const TextStyle(fontSize: 10),
                ),
                Bullet(),
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
          if (readData(StorageKey.showShopUPI) ?? false)
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
    final style = titleStyle ?? TextStyle(fontSize: 11, fontWeight: FontWeight.bold);

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
