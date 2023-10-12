import 'package:flutter/material.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

SingleChildScrollView addCustomerForm(controller) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Form(
      key: controller.customerFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PoSInputField(
            controller: controller.cName,
            label: "Customer Name",
            hint: "Full Customer Name",
            validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
          ),
          // Row(
          //   children: [
          PoSInputField(
            controller: controller.cNumber,
            label: "Contact Number",
            hint: "9876543210",
            maxLength: 10,
            prefixText: "+91 ",
            validator: (p0) => p0.toString().trim().length < 10 ? "Cant be empty" : null,
          ),
          PoSInputField(
            label: "E-mail",
            controller: controller.cEmail,
            validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
            hint: "Email address",
          ),
          //   ],
          // ),
          PoSInputField(
            label: "Address",
            controller: controller.cAddress,
            hint: "Full address",
            validator: (p0) => p0.toString().trim() == '' ? "Cant be empty" : null,
            maxLines: 2,
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (controller.customerFormKey.currentState!.validate()) {
                controller.addCustomer();
              }
            },
            icon: const Icon(Icons.add),
            label: const Text("Add new Customer"),
          ),
        ],
      ),
    ),
  );
}
