import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/drawer/manage_user/manage_user_c.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';
import 'package:pos/src/widgets/search_field.dart';

class ManageUser extends GetWidget<ManageUserController> {
  const ManageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Manage Users"),
            bottom: const TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.manage_accounts),
                  child: Text('Manage'),
                ),
                Tab(
                  icon: Icon(Icons.add_business_rounded),
                  child: Text('Add users'),
                ),
                // Tab(
                //   icon: Icon(Icons.add_business_rounded),
                //   child: Text(
                //     'Manage users by id',
                //     textAlign: TextAlign.center,
                //   ),
                // ),
              ],
            ),
          ),
          body: TabBarView(
            // physics: FixedExtentScrollPhysics(),
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                // child: ListView(
                //   children: [
                // ElevatedButton(
                //   onPressed: () => showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //       title: const Text("Get user info by id"),
                //       content: TextField(
                //         keyboardType: const TextInputType.numberWithOptions(signed: true),
                //         controller: controller.idcontroller,
                //         onChanged: (val) {},
                //       ),
                //       actions: [
                //         ElevatedButton(onPressed: () {}, child: const Text("Get user info")),
                //         ElevatedButton(onPressed: () => Get.back(), child: const Text("Cancel")),
                //       ],
                //     ),
                //   ),
                //   child: const Text("Get user by id"),
                // ),
                // SearchField(),

                // ],
                // ),
                child: Placeholder(),
              ),
              Form(
                key: controller.signupKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Add a new user", style: Theme.of(context).textTheme.displaySmall),
                      PoSInputField(
                        controller: controller.nameTxtController,
                        label: 'Name',
                        hint: "Full User name",
                        validator: (_val) => _val!.trim().isEmpty ? "Name Can't empty" : null,
                        onChanged: (val) {
                          log('name: $val');
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Select role",
                          ),
                          isDense: true,
                          // validator: (dd)=> ,
                          onSaved: (nV) {
                            log("Dropdown OnSaved $nV");
                          },
                          // hint: const Text("Select USER_ROLE"),
                          value: controller.defaultRole.isNotEmpty ? controller.defaultRole : null,
                          items: controller.roles.map((String category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(
                                        Icons.roller_shades,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(category),
                                  ],
                                ));
                          }).toList(),
                          onChanged: (val) {
                            log("Dropdown changed: $val-${val.runtimeType}");
                            controller.selectedRole.value = val.toString();
                          },
                          validator: (value) => value.toString().trim().isEmpty ? "Please select role" : null,
                        ),
                      ),
                      PoSInputField(
                        label: 'Mobile',
                        controller: controller.mobileTxtController,
                        hint: "Phone Number",
                        numbersOnly: true,
                        maxLength: 10,
                        prefixText: "+91 ",
                        onChanged: (val) {
                          log('Phone: $val');
                        },
                        validator: (_val) {
                          if (_val!.trim().isNotEmpty) {
                            if (_val.trim().length < 10) {
                              return "Number must be 10 digits";
                            } else {
                              return null;
                            }
                          }
                          return "Mobile Number can't be empty";
                        },
                      ),
                      PoSInputField(
                        label: 'E-mail',
                        controller: controller.emailTxtController,
                        hint: "User's personal email",
                        validator: (_val) => _val!.trim().isEmpty ? "Can't empty" : null,
                        onChanged: (val) {
                          log('email: $val');
                        },
                      ),
                      Row(
                        children: [
                          Obx(() => PoSInputField(
                                label: 'Password',
                                controller: controller.passTxtController,
                                hint: "Super Secure Password",
                                validator: (_val) => _val!.trim().isEmpty ? "Can't empty" : null,
                                obscureText: controller.isObscure.value,
                                onChanged: (val) {
                                  log('Password: $val');
                                },
                              )),
                          IconButton(
                            onPressed: () {
                              controller.isObscure.value = !controller.isObscure.value;
                            },
                            icon: Obx(
                              () => Icon(
                                controller.isObscure.value ? Icons.remove_red_eye : Icons.elderly_woman_sharp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (controller.signupKey.currentState!.validate()) {
                            // proceed
                            log("PERFECT");
                            log('${controller.nameTxtController.text}\n${controller.selectedRole.value}\n${controller.mobileTxtController.text}\n${controller.emailTxtController.text}\n${controller.passTxtController.text}');
                            controller.addUser();
                          } else {
                            // showSnackbar("Can't add user", "Please fill all fields perfectly");
                          }
                        },
                        icon: const Icon(Icons.add_box_sharp),
                        label: const Text("Add New User"),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
