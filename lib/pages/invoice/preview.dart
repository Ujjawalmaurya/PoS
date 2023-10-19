import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pos/pages/invoice/helper/pdf_invoice_helper.dart';
import 'package:pos/pages/invoice/model/invoice.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:printing/printing.dart';

class PDFPreview extends StatelessWidget {
  final Invoice invoice;
  const PDFPreview({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    log("Data in preview window=> ${invoice.customer.name}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        loadingWidget: const LinearProgressIndicator(),
        onPrinted: (context) => notifyUser(context, "Invoice printed successfully"),
        // onError: (context, error) => notifyUser(context, 'Error $error'),
        onShared: (context) => log("Shared"),
        shareActionExtraSubject: "Invoice for ${invoice.customer.name}'s purchase",
        build: (c) => PDFInvoiceHelper.generate(invoice),
        onPrintError: (context, error) => notifyUser("Error in Printing", "${error.message}"),
      ),
    );
  }
}
