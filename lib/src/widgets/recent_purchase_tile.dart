import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';

class RecentPurchaseTile extends StatelessWidget {
  RecentPurchaseTile({
    super.key,
    required this.name,
    required this.invoiceNumber,
    this.onTap,
    required this.amount,
  });

  final String name;
  final String invoiceNumber;
  final dynamic amount;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name),
      subtitle: Text("$invoiceNumber"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Amount"),
          Text(Utils.parseInINR(amount)),
        ],
      ),
    );
  }
}
