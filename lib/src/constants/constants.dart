import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pos/shop_manager/navbar_c.dart';

String formatDate(DateTime dateTime) {
  return DateFormat.yMMMMd('en_US').format(dateTime).toString();
}

String formatTime(DateTime dateTime) {
  return DateFormat.jms('en_US').format(dateTime).toString();
}

String formatWeekDay(DateTime dateTime) {
  return DateFormat.EEEE('en_US').format(dateTime).toString();
}

//! ==== GetStorage ====

final storage = GetStorage();

void writeData(key, value) => storage.write(key, value).onError(
      (error, stackTrace) => log(
        "err while writing $key $error",
      ),
    );
readData(key) => storage.read(key);
void removeData(key) => storage.remove(key).onError(
      (error, stackTrace) => log(
        "ERR: $key $error",
      ),
    );
void eraseStorage() => storage.erase().onError(
      (error, stackTrace) => log(
        "ERR while erasing storage $error",
      ),
    );

// User Roles
// SALESMAN, STORE_MANAGER, STORE_OWNER, ADMIN

bool ifSalesMan() {
  String userRole = Get.find<UserController>().userRole;
  return (userRole == 'SALESMAN'
      // userRole == 'STORE_MANAGER' ||
      // userRole == 'STORE_OWNER' ||
      // userRole == 'ADMIN'
      )
      ? true
      : false;
  // return
}
