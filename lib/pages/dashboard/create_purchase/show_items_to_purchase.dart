import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/src/widgets/search_field.dart';

// class ShowItemsToPurchase extends GetWidget<PurchaseController> {
//   const ShowItemsToPurchase({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Items"),
//       ),
//       body: Column(
//         children: [
//           const SearchField(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: controller.inventoryController.inventoryData.length,
//               itemBuilder: (context, index) {
//                 var item = controller.inventoryController.inventoryData[index];
//                 return ListTile(
//                   title: Text(item['name']),
//                   subtitle: Text("in stock ${item['stock']}"),
//                   trailing: Text("Price: ${item['price']}"),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
