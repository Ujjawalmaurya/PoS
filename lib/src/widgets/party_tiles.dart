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
    return Card(
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: 18, horizontal: 5),
        // return ExpansionTile(

        // onTap: onTap,
        // isThreeLine: true,
        leading: NetworkImageLoader(image: image),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle ?? "${Utils.formatDate(DateTime.now())}",
            style: Theme.of(context).textTheme.labelMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amountType, style: Theme.of(context).textTheme.bodySmall),
                Text(Utils.parseInINR(amount), style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                onPressed: onTap,
                icon: const Icon(Icons.more_vert_outlined))
          ],
        ),
        children: const [
          ListTile(title: Text("Recent transaction 01")),
          ListTile(title: Text("Recent transaction 02")),
          ListTile(title: Text("Recent transaction 03")),
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
    required this.ownerName,
    required this.amount,
    required this.amountType,
    required this.businessName,
    required this.gstNumber,
    this.onTap,
  });

  final String name;
  final dynamic amount;
  final String amountType;
  final String businessName;
  final String ownerName;
  final String gstNumber;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Owner: $ownerName'),
                  Text('GST: $gstNumber'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
