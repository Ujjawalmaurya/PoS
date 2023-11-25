import 'package:pos/pages/parties/customer_model.dart';

import 'supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String itemName;
  final int quantity;
  final double gst;
  final DateTime expiryDate;
  final double unitPrice;

  const InvoiceItem({
    required this.itemName,
    required this.quantity,
    required this.gst,
    required this.expiryDate,
    required this.unitPrice,
  });
}
