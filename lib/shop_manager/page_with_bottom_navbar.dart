import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:pos/shop_manager/navbar_c.dart';

class BottomNavigationBarPage extends GetWidget<BottomNavigationBarController> {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color _color = Theme.of(context).primaryColor;
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // drawer: Drawer(),
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
