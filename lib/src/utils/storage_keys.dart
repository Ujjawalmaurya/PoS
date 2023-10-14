class StorageKey {
  // static const String = '';
  // static const String = '';
  // static const String = '';
  // static const String = '';
  // static const String = '';

  static Settings settings = const Settings();
  static User user = const User();
}

class Settings {
  const Settings();
  String get isMaterial3 => 'isMaterial3';
  String get closeAppOnLogout => 'closeAppOnLogout';
  String get showShopUPI => 'showShopUPI';
  String get showShopAdd => 'showShopAdd';
  String get hideGSTperItem => 'hideGSTperItem';
  String get showInvoiceQR => 'showInvoiceQR';
  String get isInvoiceLandscape => 'isInvoiceLandscape';
  // String get  => '';

  // static const String isMaterial3 = 'isMaterial3';
  // static const String closeAppOnLogout = 'closeAppOnLogout';
  // static const String showShopUPI = 'showShopUPI';
  // static const String showShopAdd = 'showShopAdd';
  // static const String hideGSTperItem = 'hideGSTperItem';
  // static const String showInvoiceQR = 'showInvoiceQR';
}

class User {
  const User();
  String get accessToken => 'accesstoken';
  String get refreshToken => 'refreshtoken';
  String get userData => 'userData';
  // String get  => '';
  // String get  => '';

  // static const String accessToken = 'accesstoken';
  // static const String refreshToken = 'refreshtoken';
  // static const String userData = 'userData';
}


// 
// 
// 
// 



//  sturcture = 'userData',
//       {
//         'id': _bodyData['id'],
//         'name': _bodyData['name'],
//         'email': _bodyData['email'],
//         'mobile': _bodyData['mobile'],
//         'role': _bodyData['role'],
//         'businessDetails': _bodyData['businessDetails'],
//         'businessId': _bodyData['businessId'],
//         'active': _bodyData['active'],
//       },
