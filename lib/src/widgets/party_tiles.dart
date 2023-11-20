import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/lazy_network_image.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.name,
    required this.amount,
    required this.amountType,
    this.onTap,
    this.subtitle,
    this.image = "https://robohash.org/odioquivero.png",
  });

  final String name;
  final dynamic amount;
  final String amountType;
  final String image;
  final String? subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // return ExpansionTile(
      // children: [
      //   const ListTile(title: Text("Recent transaction 01")),
      //   const ListTile(title: Text("Recent transaction 02")),
      //   const ListTile(title: Text("Recent transaction 03")),
      // ],

      onTap: onTap,
      isThreeLine: true,
      // leading: Image.network(image),
      leading: NetworkImageLoader(image: image),
      title: Text(name, style: const TextStyle(fontSize: 18)),
      subtitle: Text(subtitle ?? "${Utils.formatDate(DateTime.now())}"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amountType),
          Text(Utils.parseInINR(amount)),
        ],
      ),
    );
  }
}

class SupplierTile extends StatelessWidget {
  const SupplierTile({
    super.key,
    required this.name,
    // this.image = 'https://robohash.org/odioquivero.png',
    this.image = 'https://robohash.org/ujjawal',
    required this.amount,
    required this.amountType,
    required this.businessName,
    this.onTap,
  });

  final String name;
  final dynamic amount;
  final String amountType;
  final String businessName;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NetworkImageLoader(image: image),
      onTap: onTap,
      isThreeLine: true,
      title: Text(name, style: const TextStyle(fontSize: 18)),
      subtitle: Text(businessName),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amountType),
          Text(Utils.parseInINR(amount)),
        ],
      ),
    );
  }
}
