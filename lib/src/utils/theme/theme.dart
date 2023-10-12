import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/utils/theme/textTheme.dart';

Color _primaryColor = Colors.teal;
MaterialColor _primarySwatch = Colors.teal;
Brightness _brightness = Brightness.light;
// Color _accentColor = Colors.yellow;

class PoSAppTheme {
  // PoSAppTheme._();

// ! LIGHT Theme

  static ThemeData lightTheme = ThemeData(
    // colorSchemeSeed: _primaryColor,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Colors.deepPurpleAccent,
    //   brightness: Brightness.light,
    // ),
    useMaterial3: readData('isMaterial3') ?? false,
    brightness: _brightness,
    primaryColor: _primaryColor,
    primarySwatch: _primarySwatch,
    fontFamily: 'Rubik',
    tabBarTheme: TabBarTheme(
      labelColor: _primaryColor,
    ),
    // FAB
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: _accentColor,
    // ),
    // iconTheme: IconThemeData(
    // weight: 600,
    // color: Colors.deepPurpleAccent,
    // ),
    drawerTheme: const DrawerThemeData(
      elevation: 12,
    ),
    cardTheme: CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _primarySwatch,
        // systemNavigationBarContrastEnforced: true,
        systemNavigationBarColor: _primaryColor,
        systemNavigationBarDividerColor: Colors.yellowAccent,
      ),
    ),
    searchBarTheme: const SearchBarThemeData(
      elevation: MaterialStatePropertyAll(0),
    ),
    dividerTheme: const DividerThemeData(indent: 10, endIndent: 10),
    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        elevation: const MaterialStatePropertyAll(5),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStatePropertyAll<BorderSide>(BorderSide(width: 2, color: _primarySwatch)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
      ),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   suffixIconColor: Colors.blue.withOpacity(0.7),
    //   isDense: true,
    //   // activeIndicatorBorder: BorderSide(width: 2),
    //   border: InputBorder.none,
    //   outlineBorder: const BorderSide(width: 2, color: Colors.redAccent),
    //   // fillColor: Colors.grey,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 26,
      ),
      // labelStyle: const TextStyle(
      //   fontSize: 45,
      //   decorationColor: Colors.red,
      // ),
      labelStyle: TextStyle(
        color: _primarySwatch,
      ),
    ),
  );

// !DARK theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: PoSTextTheme.darkTextTheme,
  );
} //
