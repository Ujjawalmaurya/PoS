import 'package:get/get.dart';
import 'package:pos/get/bindings.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/otp/otpScreen.dart';
import 'package:pos/pages/scanner/scanner.dart';
import 'package:pos/shop_boy/shopboy.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/add_purchase.dart';
import 'package:pos/shop_manager/dashboard/create_sale/add_sales.dart';
import 'package:pos/shop_manager/dashboard/create_sale/show_customers.dart';
import 'package:pos/shop_manager/dashboard/create_sale/show_items_for_sale.dart';
import 'package:pos/shop_manager/dashboard/drawer/about_us.dart';
import 'package:pos/shop_manager/dashboard/drawer/account_settings.dart';
import 'package:pos/shop_manager/dashboard/drawer/invoice_settings.dart';
import 'package:pos/shop_manager/dashboard/drawer/manage_user/manage_users.dart';
import 'package:pos/shop_manager/dashboard/drawer/profile/profile.dart';
import 'package:pos/shop_manager/dashboard/home.dart';
import 'package:pos/shop_manager/inventory/add_inventory/add_inventory.dart';
import 'package:pos/shop_manager/marketing/marketing.dart';
import 'package:pos/shop_manager/page_with_bottom_navbar.dart';
import 'package:pos/shop_manager/parties/add_party/add_parties.dart';
import 'package:pos/shop_owner/shop_owner.dart';

class Routes {
  static List<GetPage> pages = [
// ! Common

    GetPage(
      name: '/login',
      page: () => const Login(),
      //  binding: (),
    ),
    GetPage(
      name: '/otp',
      page: () => OTPScreen(),
      binding: OTPBindings(),
    ),

    // ! Shop owner
    GetPage(
      name: '/STORE_OWNER',
      page: () => const ShopOwner(),
      //  binding: (),
    ),

    // ! Shop Manager

    GetPage(
      name: '/STORE_MANAGER',
      page: () => const BottomNavigationBarPage(),
      binding: BottomNavigationBarBinding(),
    ),
    // GetPage(
    //   name: '/home',
    //   page: () => const TabOne(),
    // binding: HomeBinding(),
    // ),
    GetPage(
      name: '/marketing',
      page: () => Marketing(),
      // binding: MarketingBinding(),
    ),
    GetPage(
      name: '/myProfile',
      page: () => MyProfile(),
      binding: MyProfileBinding(),
    ),

    GetPage(
      name: '/addSales',
      page: () => AddSales(),
      binding: AddSalesBinding(),
    ),

    GetPage(
      name: '/showCustomersForSale',
      page: () => const ShowCustomersForSale(),
      //  binding: (),
    ),

    GetPage(
      name: '/showItemsToSale',
      page: () => const ShowItemsForSale(),
      transition: Transition.zoom,
      // transition: Transition.size,
      // customTransition: CustomTransition(),
      // transitionDuration: Duration(seconds: 3),
    ),

    GetPage(
      name: '/addPurchase',
      page: () => const AddPurchase(),
      //  binding: (),
    ),

    GetPage(
      name: '/invoiceSettings',
      page: () => const InvoiceSettings(),
      //  binding: (),
    ),
    GetPage(
      name: '/accountSettings',
      page: () => const AccountSettings(),
      //  binding: (),
    ),
    GetPage(
      name: '/manageUser',
      page: () => ManageUser(),
      binding: ManageUserBindings(),
    ),
    GetPage(
      name: '/aboutUs',
      page: () => const AboutUs(),
      //  binding: (),
    ),
    GetPage(
      name: '/scanner',
      page: () => const Scanner(),
      //  binding: (),
    ),
    GetPage(
      name: '/addInventory',
      page: () => const AddInventory(),
      binding: AddInventoryBinding(),
    ),
    GetPage(
      name: '/addParties',
      page: () => const AddParties(),
      binding: AddPartyBinding(),
    ),
    // GetPage(
    //   name: '/',
    //   page: () => const (),
    //    binding: (),
    // ),

    // ! Shop Boy
    GetPage(
      name: '/SALESMAN',
      page: () => const ShopBoy(),
      // binding: (),
    ),

    // GetPage(
    //   name: '/',
    //   page: () => const (),
    //    binding: (),
    // ),
  ];
}
