import 'package:get/get.dart';
import 'package:pos/pages/otp/otp_c.dart';
import 'package:pos/shop_manager/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/shop_manager/dashboard/create_sale/sales_c.dart';
import 'package:pos/shop_manager/dashboard/drawer/profile/profile_c.dart';
import 'package:pos/shop_manager/dashboard/home_c.dart';
import 'package:pos/shop_manager/inventory/add_inventory/add_inventory_c.dart';
import 'package:pos/shop_manager/inventory/inventory_c.dart';
import 'package:pos/shop_manager/marketing/marketing_c.dart';
import 'package:pos/shop_manager/navbar_c.dart';
import 'package:pos/shop_manager/parties/add_party/add_party_c.dart';
import 'package:pos/shop_manager/parties/party_c.dart';

import '../shop_manager/dashboard/drawer/manage_user/manage_user_c.dart';

class BottomNavigationBarBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<UserController>(() => UserController());
    UserController _ = Get.put(UserController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MarketingController>(() => MarketingController());
    PartyController partyController = Get.put(PartyController());
    InventoryController inventoryItemsController = Get.put(InventoryController());
    // Get.lazyPut<PartyController>(() => PartyController());
    // Get.lazyPut<InventoryController>(() => InventoryController());
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MyProfileController>(MyProfileController());
  }
}

class AddSalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSalesController>(() => AddSalesController());
  }
}

class ManageUserBindings implements Bindings {
  @override
  void dependencies() {
    // ManageUserController controller = Get.put(ManageUserController());
    Get.lazyPut<ManageUserController>(() => ManageUserController());
  }
}

class OTPBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPController>(() => OTPController());
  }
}

class AddPartyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPartyController>(() => AddPartyController());
  }
}

class AddInventoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInventoryController>(() => AddInventoryController());
  }
}

class PurchaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseController>(() => PurchaseController());
  }
}

// class  implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<>(() => ());
//   }
// }

