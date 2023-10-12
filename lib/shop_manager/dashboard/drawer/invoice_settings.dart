import 'package:flutter/material.dart';
import 'package:pos/src/constants/constants.dart';

class InvoiceSettings extends StatefulWidget {
  const InvoiceSettings({super.key});

  @override
  State<InvoiceSettings> createState() => _InvoiceSettingsState();
}

class _InvoiceSettingsState extends State<InvoiceSettings> {
  bool showShopUPI = readData('showShopUPI') ?? false;
  bool showShopAdd = readData('showShopAdd') ?? false;
  bool hideGSTperItem = readData('hideGSTperItem') ?? false;
  bool showInvoiceQR = readData('showInvoiceQR') ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Settings"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            isThreeLine: true,
            dense: true,
            title: const Text("Show Shop UPI"),
            subtitle:
                const Text("This action to show up UPI ID of shop where customer paid the purchase amount"),
            value: showShopUPI,
            onChanged: (_val) => setState(() {
              showShopUPI = _val;
              writeData('showShopUPI', _val);
            }),
          ),
          SwitchListTile(
            isThreeLine: true,
            dense: true,
            title: const Text("Show Shop Adress"),
            subtitle: const Text("Show shop Address on the bill"),
            value: showShopAdd,
            onChanged: (_val) => setState(() {
              showShopAdd = _val;
              writeData('showShopAdd', _val);
            }),
          ),
          SwitchListTile(
            isThreeLine: true,
            dense: true,
            title: const Text("Hide GST per item"),
            subtitle: const Text("Allow customers NOT to see GST amount per item."),
            value: hideGSTperItem,
            onChanged: (_val) => setState(() {
              hideGSTperItem = _val;
              writeData('hideGSTperItem', _val);
            }),
          ),
          SwitchListTile(
            isThreeLine: true,
            dense: true,
            title: const Text("Show QR for Invoice number"),
            subtitle: const Text("Shows up a QR for invoice along with invoice number"),
            value: showInvoiceQR,
            onChanged: (_val) => setState(() {
              showInvoiceQR = _val;
              writeData('showInvoiceQR', showInvoiceQR);
            }),
          ),
        ],
      ),
    );
  }
}
