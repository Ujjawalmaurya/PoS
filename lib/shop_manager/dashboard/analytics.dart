import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  Analytics({super.key});

  final List _data = [
    {'color': Colors.red, "icon": Icons.read_more, 'title': 'To collect'},
    {'color': Colors.green, "icon": Icons.read_more, 'title': 'To Pay'},
    {'color': Colors.pink, "icon": Icons.read_more, 'title': 'Value of Items'},
    {'color': Colors.deepPurple, "icon": Icons.read_more, 'title': 'This week\'s sale'},
    {'color': Colors.deepOrange, "icon": Icons.read_more, 'title': 'Cash + BAnk balance'},
    {'color': Colors.grey, "icon": Icons.read_more, 'title': 'Party, GST/...'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 80, crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
        var data = _data[index];
        return InkWell(
          child: SizedBox(
            height: 50,
            child: Card(
              margin: const EdgeInsets.all(6),
              color: data['color'].shade300.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Amount"),
                        Text(data['title'].toString()),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
