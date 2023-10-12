import 'package:flutter/material.dart';
import 'package:pos/src/constants/constants.dart';

class ShopOwner extends StatefulWidget {
  const ShopOwner({super.key});

  @override
  State<ShopOwner> createState() => _ShopOwnerState();
}

class _ShopOwnerState extends State<ShopOwner> {
  String date = readData('date') ?? "Null date";
  String accToken = readData('accessToken') ?? "Null acc token";
  String refrToken = readData('refreshToken') ?? "Null refresh token";
  Map data = readData('userData') ?? {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Owner")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date, textAlign: TextAlign.center),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: Text(accToken, textAlign: TextAlign.center)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(refrToken, textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data.toString(), textAlign: TextAlign.center),
          ),
          //
        ],
      ),
    );
  }
}
