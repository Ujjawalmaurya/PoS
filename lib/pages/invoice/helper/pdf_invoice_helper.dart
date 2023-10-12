import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:pos/src/constants/constants.dart';

import '../../../src/utils/utils.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import 'pdf_helper.dart';

class PDFInvoiceHelper {
  static Future<File> generate(Invoice invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          buildHeader(invoice),
          SizedBox(height: 3 * PdfPageFormat.cm),
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

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              if (readData('showInvoiceQR') ?? false)
                Container(
                  height: 25,
                  width: 25,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.info.number,
                  ),
                ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>['Invoice Number:', 'Invoice Date:', 'Payment Terms:', 'Due Date:'];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      paymentTerms,
      Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            supplier.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          if (readData('showShopAdd') ?? false) Text(supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paperlessly Outlet One(1)',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = ['Item', 'Qty', 'Unit Price', 'GST', 'Total'];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + (item.gst / 100));

      return [
        item.itemName,
        // Utils.formatDate(item.date),
        '${item.quantity}',
        'Rs ${item.unitPrice}',
        '${item.gst} %',
        'Rs ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey200),
      cellHeight: 4,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
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
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: netTotal.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'GST $gstPercent%',
                  value: "$gst",
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
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
          if (readData('showShopUPI') ?? false) buildSimpleText(title: 'UPI', value: invoice.supplier.upi),
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
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

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
