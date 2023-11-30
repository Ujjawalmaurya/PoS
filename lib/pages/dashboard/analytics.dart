import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class Analytics extends StatelessWidget {
  Analytics({super.key});

  final List _data = [
    {
      'color': Colors.red,
      "icon": Icons.collections_bookmark_sharp,
      'title': 'To collect',
      'value': Utils.parseInINR(8734)
    },
    {
      'color': Colors.green,
      "icon": Icons.payment,
      'title': 'To Pay',
      'value': "Utils",
    },
    {
      'color': Colors.pink,
      "icon": Icons.vaccines_outlined,
      'title': 'Value of Items',
      'value': Utils.parseInINR(544),
    },
    {
      'color': Colors.deepPurple,
      "icon": Icons.weekend_sharp,
      'title': 'This week\'s sale',
      'value': Utils.parseInINR(8575),
    },
    {
      'color': Colors.deepOrange,
      "icon": Icons.cabin_sharp,
      'title': 'Cash + Bank balance',
      'value': Utils.parseInRs(87) + ' ' + Utils.parseInRs(587),
    },
    {
      'color': Colors.cyan,
      "icon": Icons.private_connectivity_sharp,
      'title': 'Party, GST/...',
      'value': "Utils"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var _d = _data[index];
          return InkWell(
            onTap: () => MassengerScaffold.notifyUser(context, "${_d['title']} pressed"),
            child: SizedBox(
              width: Get.width * 0.75,
              child: Card(
                margin: const EdgeInsets.all(8),
                color: _d['color'],
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      _d['icon'],
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      _d['value'],
                      style: const TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    Text(
                      "${_d['title']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      selectionColor: Colors.white,
                    ),
                  ],
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
