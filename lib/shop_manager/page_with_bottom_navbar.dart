import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos/shop_manager/navbar_c.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/storage_keys.dart';

class BottomNavigationBarPage extends GetWidget<NavigationBarController> {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _color = Theme.of(context).primaryColor;
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: controller.navbarScaffoldKey,
      // drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).dividerColor),
              child: Column(
                children: [
                  Text(
                    readData(StorageKey.user.userData)['name'],
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text("Role: ${readData(StorageKey.user.userData)['role']}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text("Account", style: Theme.of(context).textTheme.headlineSmall),
            ),
            ListTile(
                leading: const Icon(Icons.person),
                onTap: () => Get.toNamed('/myProfile'),
                title: const Text("Profile")),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text("Settings", style: Theme.of(context).textTheme.headlineSmall),
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file_rounded),
              title: const Text("Invoice Settings"),
              onTap: () => Get.toNamed('/invoiceSettings'),
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts_rounded),
              title: const Text("Account Settings"),
              onTap: () => Get.toNamed('/accountSettings'),
            ),
            ListTile(
              leading: const Icon(Icons.read_more_outlined),
              title: const Text("Reminder Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle_sharp),
              title: const Text("Manage User"),
              onTap: () => Get.toNamed('/manageUser'),
            ),
            ListTile(
                leading: const Icon(Icons.delete_sweep_outlined),
                title: const Text("Recover Deleted Invoices"),
                onTap: () {}),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                splashColor: Colors.pinkAccent,
                onTap: () {},
                leading: const Icon(
                  Icons.star_border_purple500_sharp,
                  size: 45,
                  color: Colors.brown,
                ),
                titleTextStyle: Theme.of(context).textTheme.titleMedium,
                textColor: Colors.brown,
                title: const Text("You're a PLUS member"),
                subtitle: const Text("Expires on XX-XX-XXXX"),
                tileColor: Colors.yellow.shade100,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_center_sharp),
              title: const Text("Help & Support"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.chrome_reader_mode_rounded),
              title: Text("About us"),
              onTap: () => Get.toNamed('/aboutUs'),
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text("Logout"),
                onTap: () => controller.logout(context)),
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
                HapticFeedback.lightImpact();
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
