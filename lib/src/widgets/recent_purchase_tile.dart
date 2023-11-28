import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';

class RecentPurchaseTile extends StatelessWidget {
  RecentPurchaseTile({
    super.key,
    required this.name,
    this.dateTime,
    required this.amount,
  });

  final String name;
  final DateTime? dateTime;
  final dynamic amount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // onTap: () {},
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
