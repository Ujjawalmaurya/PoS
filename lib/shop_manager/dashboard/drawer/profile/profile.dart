import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/drawer/profile/profile_c.dart';
import 'package:pos/src/widgets/dotted_border_widget.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';
import 'package:pos/src/widgets/pos_loading.dart';

class MyProfile extends GetWidget<MyProfileController> {
  static const String path = '/myProfile';
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SizedBox(
        width: Get.width,
        child: FutureBuilder(
          future: controller.getProfile(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const ShowLoading();
              case ConnectionState.done:
                return snapshot.hasError || !snapshot.hasData
                    ? Center(child: Text("Some error ${snapshot.error}"))
                    :
                    //  InkWell(
                    //     onTap: () {
                    //       showDialog(
                    //         context: context,
                    //         builder: (context) => AlertDialog(
                    //           title: const Text("Select an action"),
                    //           content: const Text('Update or delete'),
                    //           actions: [
                    //             OutlinedButton(onPressed: () {}, child: const Text("Update User")),
                    //             ElevatedButton(
                    //               onPressed: () {},
                    //               style: const ButtonStyle(
                    //                   backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    //               child: const Text("Delete User"),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //     child:
                    SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: Get.height * 0.85,
                          child: Form(
                            key: controller.profileFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    // backgroundImage: const NetworkImage(
                                    //   'https://robohash.org/doloremquesintcorrupti.png',
                                    // ),
                                    maxRadius: 55,
                                    child: Text(
                                      snapshot.data['name'][0],
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${snapshot.data['name']}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                // MyDottedBorderWidget(
                                //   child: Text(
                                //     "User-id: ${snapshot.data['id']}\nBusiness-id: ${snapshot.data['businessId']}",
                                //     textAlign: TextAlign.center,
                                //     // style: Theme.of(context).textTheme.headlineSmall,
                                //   ),
                                // ),
                                PoSInputField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.storeNameCrt,
                                  // initialValue: "Some Store name",
                                  hint: "Store Name",
                                  label: "Store Name",
                                ),
                                // Text(
                                //   "role: ${controller.body['role']}",
                                //   style: Theme.of(context).textTheme.labelMedium,
                                // ),
                                PoSInputField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.emailCtr,
                                  // initialValue: snapshot.data['email'],
                                  hint: "Email",
                                  label: "Email",
                                ),
                                PoSInputField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.numberCtr,
                                  // initialValue: snapshot.data['mobile'],
                                  hint: "Mobile",
                                  label: "Mobile number",
                                  maxLength: 10,
                                  prefixText: "+91 ",
                                ),
                                PoSInputField(
                                  readOnly: true,
                                  obscureText: true,
                                  // initialValue: "password: ${snapshot.data['password']}",
                                  hint: "Obscured PAssword",
                                  label: "Passowrd",
                                ),

                                PoSInputField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Field is required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.businessAddCtr,
                                  label: "Business Address",
                                  hint: "Complete address",
                                  maxLines: 4,
                                ),
                                Text(
                                  "Business Details: ${snapshot.data['businessDetails']}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (controller.profileFormKey.currentState!.validate()) {
                                      log("Valid");
                                    } else {
                                      log("Invalid validation(s)");
                                    }
                                  },
                                  icon: const Icon(Icons.upload_file_outlined),
                                  label: const Text("Update Profile"),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
              default:
                return const Text("ERR");
            }
          },
        ),
        // ElevatedButton(
        //   onPressed: () async => await Haptics.light(),
        //   child: const Text("Ligh haptic"),
        // ),
        // ElevatedButton(
        //   onPressed: () async => await Haptics.medium(),
        //   child: const Text("Medium haptic"),
        // ),
        // ElevatedButton(
        //   onPressed: () async => await Haptics.heavy(),
        //   child: const Text("heavy haptic"),
        // ),
        // ElevatedButton(
        //   onPressed: () async => await Haptics.selectionClick(),
        //   child: const Text("Selection click haptic"),
        // ),
        // ElevatedButton(
        //   onPressed: () async => await Haptics.vibrate,
        //   child: const Text("onvibreath haptic"),
        // ),
      ),
      //         ),
      // ),
    );
  }
}
