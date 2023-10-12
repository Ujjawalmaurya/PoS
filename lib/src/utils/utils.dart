import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//! Amount Formatter

// final inr = NumberFormat('\₹##,###.00', 'en-HI');
// final fUS = NumberFormat('\$###,###.00', 'en-US');

// TODO: More utilisation of it

class Utils {
  // To format Dates
  static formatDate(DateTime date) => DateFormat.yMMMMd().format(date);

  // to format price in INR
  static parseInINR(dynamic amount) => NumberFormat.currency(
        symbol: '₹',
        locale: "HI",
        decimalDigits: 2,
      ).format(amount);

  // static parseInRs(dynamic amount) => NumberFormat.currency(
  //       symbol: 'Rs.',
  //       locale: "HI",
  //       decimalDigits: 2,
  //     ).format(amount);

  static parseInRs(double price) => '\Rs ${price.toStringAsFixed(2)}';

  static uuid() {
    final now = DateTime.now();
    String uuid = now.microsecondsSinceEpoch.toString();
    log(uuid);
    return uuid;
  }

  static getUUID() {
    //UUID_REGX="^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$";
    // var ranAssets = RanKeyAssets();
    // String first4Str = '';
    // String middle4Digits = '';
    // String last4alphabets = '';
    // final String last4Str = UniqueKey().toString().substring(2, 7);
    // for (int i = 0; i < 8; i++) {
    //   first4Str += ranAssets.smallAlphabets[math.Random.secure().nextInt(ranAssets.smallAlphabets.length)];

    //   middle4Digits += ranAssets.digits[math.Random.secure().nextInt(ranAssets.digits.length)];

    //   last4alphabets +=
    //       ranAssets.smallAlphabets[math.Random.secure().nextInt(ranAssets.smallAlphabets.length)];
    // }

    // String uniqueRand =
    //     '$first4Str-$middle4Digits-${DateTime.now().microsecondsSinceEpoch.toString().substring(8, 12)}$last4Str-$last4alphabets';
    // log(uniqueRand);
    // return uniqueRand;

    final uID = Uuid().v1();
    log(uID.toString());
    return uID;
  }

  // static createUUID() {
  //   log(unique4thStr);
  //   return unique4thStr;
  // }

  String generateUUID() {
    final uID = uuid().v1;
    log(uID.toString());
    return uID;
  }
}

class RanKeyAssets {
  var smallAlphabets = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  var digits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
}
