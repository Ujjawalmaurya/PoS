import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pos/src/utils/utils.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.name,
    this.imageURL =
        "https://lh3.googleusercontent.com/-btsBfVtr70I/X2OrpgIPdoI/AAAAAAAAWbw/gUa8GWoMCV0TnYFtYAPZJaaa8dQKJwzpgCLcBGAsYHQ/1.3.jpg",
    this.description = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.mrp,
    this.gst = 18,
    this.quantity = 1,
    this.ontap,
    this.onIncrease,
    this.onDecrease,
    required this.price,
  });

  final void Function()? ontap;
  final void Function()? onIncrease;
  final void Function()? onDecrease;
  final String name;
  final int quantity;
  final String imageURL;
  final dynamic mrp;
  final String description;
  final double gst;
  final double price;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5, right: 8, top: 5),
                        child: Image.network(
                          imageURL,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            // Text(
                            //   description,
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(onTap: onDecrease, child: const Icon(Icons.remove)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Qty",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(quantity.toString()),
                                  ],
                                ),
                              ),
                              // Text('+'),
                              InkWell(onTap: onIncrease, child: const Icon(Icons.add)),
                            ],
                          ),
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 4, right: 4, top: 3, bottom: 1),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              // Text(
              //   "In Stock = $stock Pcs",
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
              Text(
                "GST: $gst%",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              // Text("Purchase: ${Utils.parseInINR(purchasingPrice)}"),
              // Text("Selling: ${Utils.parseInINR(sellingPrice)}"),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
