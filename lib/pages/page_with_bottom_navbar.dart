import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pos/pages/dashboard/drawer/about_us.dart';
import 'package:pos/pages/dashboard/drawer/account_settings.dart';
import 'package:pos/pages/dashboard/drawer/invoice_settings.dart';
import 'package:pos/pages/dashboard/drawer/manage_user/manage_users.dart';
import 'package:pos/pages/dashboard/drawer/profile/profile.dart';
import 'package:pos/pages/navbar_c.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/hapics.dart';
import 'package:pos/src/utils/storage_keys.dart';

class BottomNavigationBarPage extends GetWidget<UserController> {
  static const String path = '/dashboard';
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _color = Theme.of(context).primaryColor;
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      key: controller.navbarScaffoldKey,
      // drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // DrawerHeader(
            //   decoration: BoxDecoration(color: Theme.of(context).dividerColor),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //   Text(
            //     readData(StorageKey.user.userData)['name'],
            //     style: Theme.of(context).textTheme.headlineMedium,
            // textAlign: TextAlign.left,
            // ),
            // Text("Role: ${readData(StorageKey.user.userData)['role']}"),
            //     ],
            //   ),
            // ),
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.background,
                child: Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/${readData(StorageKey.user.userData)['name'][0].toString().toUpperCase()}.json',
                  // reverse: true,
                  repeat: false,
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
              accountName: Text(
                readData(StorageKey.user.userData)['name'],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              accountEmail: Text("${readData(StorageKey.user.userData)['email']}"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text("Account", style: Theme.of(context).textTheme.headlineSmall),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onTap: () => Get.toNamed(MyProfile.path),
              title: const Text("Profile"),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text("Settings", style: Theme.of(context).textTheme.headlineSmall),
            ),
            ListTile(
              leading: Icon(
                Icons.insert_drive_file_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: const Text("Invoice Settings"),
              onTap: () => Get.toNamed(InvoiceSettings.path),
            ),
            ListTile(
              leading: Icon(
                Icons.manage_accounts_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: const Text("Account Settings"),
              onTap: () => Get.toNamed(AccountSettings.path),
            ),
            // ListTile(
            //   leading: const Icon(Icons.read_more_outlined),
            //   title: const Text("Reminder Settings"),
            //   onTap: () {},
            // ),
            Get.find<UserController>().userRole == 'STORE_MANAGER'
                ? ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle_sharp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    title: const Text("Manage User"),
                    onTap: () => Get.toNamed(ManageUser.path),
                  )
                : const SizedBox.shrink(),
            // ListTile(
            //   leading: const Icon(Icons.delete_sweep_outlined),
            //   title: const Text("Recover Deleted Invoices"),
            //   onTap: () {},
            // ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                splashColor: Colors.pinkAccent,
                onTap: () {
                  Get.defaultDialog(
                    title: "",
                    content: Stack(
                      children: [
                        Lottie.network(
                          'https://lottie.host/3d58e6ad-ef07-4a2d-9e32-d12f5a9b23d1/960PhxwIrB.json',
                          // height: 200,
                          // width: 200,
                          repeat: false,
                          onLoaded: (composition) {
                            // Configure the AnimationController with the duration of the
                            // Lottie file and start the animation.
                            // controller.duration = composition.duration;
                            // controller.forward();
                          },
                          animate: true,
                          // reverse: true,
                          frameBuilder: (context, child, composition) {
                            return AnimatedOpacity(
                              child: child,
                              opacity: composition == null ? 0 : 1,
                              duration: const Duration(seconds: 5),
                              curve: Curves.easeOut,
                            );
                          },
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hurrah! You're a PLUS member",
                              textAlign: TextAlign.center,
                            ),
                            // ElevatedButton.icon(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.featured_play_list_outlined),
                            //   label: Text(
                            //     "Explore features",
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  );
                }, // TODO?
                leading: const Icon(
                  Icons.star_border_purple500_sharp,
                  size: 45,
                  color: Colors.brown,
                ),
                titleTextStyle: Theme.of(context).textTheme.titleMedium,
                textColor: Colors.brown,
                title: Text("You're a PLUS member"),
                subtitle: const Text("Expires on XX-XX-XXXX"),
                tileColor: Colors.yellow.shade100,
              ),
            ),

            const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.help_center_sharp),
            //   title: const Text("Help & Support"),
            //   onTap: () {},
            // ),
            ListTile(
              leading: Icon(
                Icons.chrome_reader_mode_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text("About us"),
              onTap: () => Get.toNamed(AboutUs.path),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: const Text("Logout"),
              onTap: () => controller.logout(context),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
      body: Obx(() => Center(
            child: controller.widgetOptions.elementAt(controller.currentIndex.value),
          )),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => Obx(
            () => InkWell(
              onTap: () {
                // setState(() {
                controller.currentIndex.value = index;
                Haptics.light();
                // });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: controller.animationDuration,
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == controller.currentIndex.value ? displayWidth * .32 : displayWidth * .18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: controller.animationDuration,
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == controller.currentIndex.value ? displayWidth * .12 : 0,
                      width: index == controller.currentIndex.value ? displayWidth * .32 : 0,
                      decoration: BoxDecoration(
                        color: index == controller.currentIndex.value
                            ? _color.withOpacity(.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: controller.animationDuration,
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == controller.currentIndex.value ? displayWidth * .31 : displayWidth * .18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: controller.animationDuration,
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == controller.currentIndex.value ? displayWidth * .12 : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == controller.currentIndex.value ? 1 : 0,
                              duration: controller.animationDuration,
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == controller.currentIndex.value ? controller.listOfStrings[index] : '',
                                style: TextStyle(
                                  color: _color,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: controller.animationDuration,
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == controller.currentIndex.value ? displayWidth * .028 : 20,
                            ),
                            Icon(
                              controller.listOfIcons[index],
                              size: displayWidth * .076,
                              color: index == controller.currentIndex.value ? _color : Colors.black26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
