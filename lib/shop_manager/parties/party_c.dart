import 'package:get/get.dart';
import 'package:pos/shop_manager/parties/partyModel.dart';
import 'package:pos/src/services/apiServices.dart';

enum Type { customer, supplier }

class PartyController extends GetxController {
  Type partyType = Type.customer;

  // RxList<Party> parties = <Party>[].obs;

  List vendors = [];
  List customers = [];

  @override
  void onInit() async {
    getCustomers();
    getVendors();
    super.onInit();
  }

  void getCustomers() async {
    customers = await APIServices.getCustomers();
    print(customers.toString());
    update();
  }

  void getVendors() async {
    vendors = await APIServices.getVendors();
    print(vendors.toString());
    update();
  }

  updatePartyType(Set<Type> _val) {
    partyType = _val.first;
    update();
  }

  // Uri uri = Uri.parse("https://dummyjson.com/users");

  // Future<List<Party>> getPartyList() async {
  //   log("Getting parties");
  //   var res = await http.get(uri, headers: BaseURL.header);
  //   if (res.statusCode == 200) {
  //     final List result = json.decode(res.body)["users"];
  //     print("Party list : " + result.toString());

  //     print(parties.toString());
  //     return result.map((e) => Party.fromJson(e)).toList();
  //   } else {
  //     throw Exception('response not oke: res:${res.statusCode}');
  //   }
  // }

//
} //
