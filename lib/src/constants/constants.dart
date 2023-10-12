import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

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


//TODO store 
