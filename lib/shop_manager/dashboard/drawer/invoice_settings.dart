import 'package:flutter/material.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';

class InvoiceSettings extends StatefulWidget {
  const InvoiceSettings({super.key});

  @override
  State<InvoiceSettings> createState() => _InvoiceSettingsState();
}

class _InvoiceSettingsState extends State<InvoiceSettings> {
  bool showShopUPI = readData(StorageKey.settings.showShopUPI) ?? false;
  bool showShopAdd = readData(StorageKey.settings.showShopAdd) ?? false;
  bool hideGSTperItem = readData(StorageKey.settings.hideGSTperItem) ?? false;
  bool showInvoiceQR = readData(StorageKey.settings.showInvoiceQR) ?? false;
  bool isInvoiceLandscape = readData(StorageKey.settings.isInvoiceLandscape) ?? false;

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
              writeData(StorageKey.settings.showShopUPI, _val);
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
              writeData(StorageKey.settings.showShopAdd, _val);
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
              writeData(StorageKey.settings.hideGSTperItem, _val);
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
              writeData(StorageKey.settings.showInvoiceQR, showInvoiceQR);
            }),
          ),
          SwitchListTile(
              isThreeLine: true,
              subtitle: const Text("Create invoices in Landscape format"),
              title: const Text("Invoice layout"),
              value: isInvoiceLandscape,
              onChanged: (bool _val) {
                setState(() {
                  isInvoiceLandscape = _val;
                  writeData(StorageKey.settings.isInvoiceLandscape, _val);
                });
              })
        ],
      ),
    );
  }
}
