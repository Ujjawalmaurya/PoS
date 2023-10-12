import 'package:flutter/material.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Purchase"),
        // centerTitle: true,
      ),
    );
  }
}
