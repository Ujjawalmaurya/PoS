import 'package:get/get.dart';
import 'package:pos/get/bindings.dart';
import 'package:pos/pages/login.dart';
import 'package:pos/pages/otp/otpScreen.dart';
import 'package:pos/pages/scanner/scanner.dart';
import 'package:pos/pages/signup.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/add_purchase.dart';
import 'package:pos/shop_manager/dashboard/create_sale/add_sales.dart';
import 'package:pos/shop_manager/dashboard/create_sale/show_customers.dart';
import 'package:pos/shop_manager/dashboard/create_sale/show_items_for_sale.dart';
import 'package:pos/shop_manager/dashboard/drawer/about_us.dart';
import 'package:pos/shop_manager/dashboard/drawer/account_settings.dart';
import 'package:pos/shop_manager/dashboard/drawer/invoice_settings.dart';
import 'package:pos/shop_manager/dashboard/drawer/manage_user/manage_users.dart';
import 'package:pos/shop_manager/dashboard/drawer/profile/profile.dart';
import 'package:pos/shop_manager/inventory/add_inventory/add_inventory.dart';
import 'package:pos/shop_manager/marketing/marketing.dart';
import 'package:pos/shop_manager/page_with_bottom_navbar.dart';
import 'package:pos/shop_manager/parties/add_party/add_parties.dart';
// import 'package:pos/shop_owner/shop_owner.dart';

class Routes {
  static List<GetPage> pages = [
// ! Common

    GetPage(
      name: Login.path,
      page: () => const Login(),
      //  binding: (),
    ),
    GetPage(
      name: SignUp.path,
      page: () => const SignUp(),
      //  binding: (),
    ),
    GetPage(
      name: OTPScreen.path,
      page: () => const OTPScreen(),
      binding: OTPBindings(),
    ),

    GetPage(
      name: BottomNavigationBarPage.path,
      page: () => const BottomNavigationBarPage(),
      binding: BottomNavigationBarBinding(),
      // middlewares: [
      //   GetMiddleware(),
      // ],
    ),
    // GetPage(
    //   name: '/home',
    //   page: () => const TabOne(),
    // binding: HomeBinding(),
    // ),
    GetPage(
      name: Marketing.path,
      page: () => Marketing(),
      // binding: MarketingBinding(),
    ),
    GetPage(
      name: MyProfile.path,
      page: () => MyProfile(),
      binding: MyProfileBinding(),
    ),

    GetPage(
      name: AddSales.path,
      page: () => AddSales(),
      binding: AddSalesBinding(),
    ),

    GetPage(
      name: ShowCustomersForSale.path,
      page: () => const ShowCustomersForSale(),
      //  binding: (),
    ),

    GetPage(
      name: ShowItemsForSale.path,
      page: () => const ShowItemsForSale(),
      transition: Transition.zoom,
      // transition: Transition.size,
      // customTransition: CustomTransition(),
      // transitionDuration: Duration(seconds: 3),
    ),

    GetPage(
      name: AddPurchase.path,
      page: () => const AddPurchase(),
      binding: PurchaseBindings(),
    ),
    GetPage(
      name: InvoiceSettings.path,
      page: () => const InvoiceSettings(),
      //  binding: (),
    ),
    GetPage(
      name: AccountSettings.path,
      page: () => const AccountSettings(),
      //  binding: (),
    ),
    GetPage(
      name: ManageUser.path,
      page: () => ManageUser(),
      binding: ManageUserBindings(),
    ),
    GetPage(
      name: AboutUs.path,
      page: () => const AboutUs(),
      //  binding: (),
    ),
    GetPage(
      name: Scanner.path,
      page: () => const Scanner(),
      //  binding: (),
    ),
    GetPage(
      name: AddInventory.path,
      page: () => const AddInventory(),
      binding: AddInventoryBinding(),
    ),
    GetPage(
      name: AddParties.path,
      page: () => AddParties(),
      binding: AddPartyBinding(),
    ),
    // GetPage(
    //   name: '/',
    //   page: () => const (),
    //    binding: (),
    // ),

    // GetPage(
    //   name: '/',
    //   page: () => const (),
    //    binding: (),
    // ),
  ];
}
