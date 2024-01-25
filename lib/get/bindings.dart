import 'package:get/get.dart';
import 'package:pos/get/auth_controller.dart';
import 'package:pos/get/authMiddleware.dart';
import 'package:pos/pages/otp/otp_c.dart';
import 'package:pos/pages/dashboard/create_purchase/purchase_c.dart';
import 'package:pos/pages/dashboard/create_sale/sales_c.dart';
import 'package:pos/pages/dashboard/drawer/profile/profile_c.dart';
import 'package:pos/pages/dashboard/home_c.dart';
import 'package:pos/pages/inventory/add_inventory/add_inventory_c.dart';
import 'package:pos/pages/inventory/inventory_c.dart';
import 'package:pos/pages/marketing/marketing_c.dart';
import 'package:pos/pages/navbar_c.dart';
import 'package:pos/pages/parties/add_party/add_party_c.dart';
import 'package:pos/pages/parties/party_c.dart';

import '../pages/dashboard/drawer/manage_user/manage_user_c.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(AuthMiddleware());
  }
}

class BottomNavigationBarBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<UserController>(() => UserController());
    NavBarController _ = Get.put(NavBarController());
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

