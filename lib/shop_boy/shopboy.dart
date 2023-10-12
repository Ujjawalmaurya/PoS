import 'package:flutter/material.dart';

class ShopBoy extends StatefulWidget {
  const ShopBoy({super.key});

  @override
  State<ShopBoy> createState() => _ShopBoyState();
}

class _ShopBoyState extends State<ShopBoy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Boy"),
      ),
    );
  }
}
