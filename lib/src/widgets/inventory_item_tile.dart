import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';
import 'package:pos/src/widgets/party_tiles.dart';

class InventoryItemTile extends StatelessWidget {
  const InventoryItemTile({
    super.key,
    required this.name,
    this.imageURL = "https://www.webyurt.com/images-o/images/photography-dusk.jpg",
    this.description = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    required this.sellingPrice,
    required this.purchasingPrice,
    required this.category,
    required this.subCategory,
    this.gst = 18,
    required this.type,
    this.stock = 0,
    this.ontap,
  });

  final void Function()? ontap;
  final String name;
  final int stock;
  final String imageURL;
  final String category;
  final String subCategory;
  final String type;
  final dynamic price;
  final String description;
  final double sellingPrice;
  final double gst;
  final double purchasingPrice;

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   isThreeLine: true,
    //   onTap: ontap,
    //   leading: Image.network(
    //     imageURL,
    //     height: 60,
    //     width: 60,
    //     fit: BoxFit.cover,
    //   ),
    //   title: Text(name),
    //   subtitle: Text(
    //     description,
    //     style: Theme.of(context).textTheme.bodySmall,
    //   ),
    //   trailing: Text(
    //     Utils.parseInINR(price),
    //     style: Theme.of(context).textTheme.bodyLarge,
    //   ),
    // );
    return GestureDetector(
      // onTapDown: (details) => log(details.toString()),
      onTap: ontap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                    backgroundColor: Colors.grey.shade200,
                    label: Text(
                      category,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Chip(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
                    backgroundColor: Colors.grey.shade200,
                    label: Text(
                      subCategory,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5, right: 8, top: 5),
                        // child: Image.network(imageURL, height: 70, width: 70, fit: BoxFit.cover),
                        child: ImageLoader(image: imageURL),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$name ($type)",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'MRP',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          Utils.parseInINR(price),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 3, bottom: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "In Stock = $stock Pcs",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      "GST: $gst%",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Purchase: ${Utils.parseInINR(purchasingPrice)}"),
                    Text("Selling: ${Utils.parseInINR(sellingPrice)}"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
