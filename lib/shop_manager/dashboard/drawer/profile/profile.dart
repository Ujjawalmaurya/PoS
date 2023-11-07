import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/dashboard/drawer/profile/profile_c.dart';
import 'package:pos/src/utils/hapics.dart';
import 'package:pos/src/widgets/pos_loading.dart';

class MyProfile extends GetWidget<MyProfileController> {
  MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: controller.getProfile(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const ShowLoading();
                  case ConnectionState.done:
                    return snapshot.hasError || !snapshot.hasData
                        ? Center(child: Text("Some error ${snapshot.error}"))
                        : InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Select an action"),
                                  content: const Text('Update or delete'),
                                  actions: [
                                    OutlinedButton(onPressed: () {}, child: const Text("Update User")),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                      child: const Text("Delete User"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    // backgroundImage: const NetworkImage(
                                    //   'https://robohash.org/doloremquesintcorrupti.png',
                                    // ),
                                    maxRadius: 60,
                                    child: Text(
                                      "U",
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                                  ),

                                  // child: const Image(
                                  //   image: NetworkImage(
                                  //     'https://robohash.org/doloremquesintcorrupti.png',
                                  //     // height: 120,
                                  //     // width: 120,
                                  //   ),
                                  // ),),
                                ),
                                Text(
                                  "User-id: ${snapshot.data['id']}",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                // Text(
                                //   "Business-id: ${snapshot.data['businessId']}",
                                //   style: Theme.of(context).textTheme.headlineSmall,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${snapshot.data['name']} (${snapshot.data['role']})",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                // Text(
                                //   "role: ${controller.body['role']}",
                                //   style: Theme.of(context).textTheme.labelMedium,
                                // ),
                                Text(
                                  "email: ${snapshot.data['email']}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  "mobile: ${snapshot.data['mobile']}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                // Text(
                                //   "password: ${controller.body['password']}",
                                //   style: Theme.of(context).textTheme.titleLarge,
                                // ),
                                Text(
                                  "Business Details: ${snapshot.data['businessDetails']}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          );
                  default:
                    return const Text("ERR");
                }
              },
            ),
            ElevatedButton(
              onPressed: () async => await Haptics.light(),
              child: const Text("Ligh haptic"),
            ),
            ElevatedButton(
              onPressed: () async => await Haptics.medium(),
              child: const Text("Medium haptic"),
            ),
            ElevatedButton(
              onPressed: () async => await Haptics.heavy(),
              child: const Text("heavy haptic"),
            ),
            ElevatedButton(
              onPressed: () async => await Haptics.selectionClick(),
              child: const Text("Selection click haptic"),
            ),
            ElevatedButton(
              onPressed: () async => await Haptics.vibrate,
              child: const Text("onvibreath haptic"),
            ),
          ],
        ),
      ),
      //         ),
      // ),
    );
  }
}
