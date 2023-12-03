import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';

class RecentSalesTile extends StatelessWidget {
  const RecentSalesTile({
    super.key,
    required this.name,
    required this.amount,
    this.dateTime,
    this.onTap,
  });

  final String name;
  final dynamic amount;
  final Function()? onTap;
  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(name),
      subtitle: Text("on ${dateTime ?? Utils.formatDate(DateTime.now())}"),
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
