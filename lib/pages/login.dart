import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/constants/constants.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController _userController = TextEditingController(text: "chocolateboyz0011@gmail.com");
TextEditingController _passController = TextEditingController(text: "64009513");
bool isObscured = true;
final _formKey = GlobalKey<FormState>();

void login(context) async {
  var res = await APIServices.login(_userController.text, _passController.text);
  var _bodyData = json.decode(res.body);
  Map<String, String> _headerData = res.headers;
  if (res.statusCode == 201) {
    log("================== Success ================");
    print('Date ==>> ${_headerData["date"]}');
    writeData('date', _headerData['date']);
    print('Access Token ==>> ${_headerData["accesstoken"]}');
    writeData('accessToken', _headerData['accesstoken']);
    print('Refresh Token ==>> ${_headerData["refreshtoken"]}');
    writeData('refreshToken', _headerData['refreshtoken']);
    log("================== Success ==================");
    print(_bodyData.toString());
    writeData(
      'userData',
      {
        'id': _bodyData['id'],
        'name': _bodyData['name'],
        'email': _bodyData['email'],
        'mobile': _bodyData['mobile'],
        'role': _bodyData['role'],
        'businessDetails': _bodyData['businessDetails'],
        'businessId': _bodyData['businessId'],
        'active': _bodyData['active'],
      },
    );
    // { id: 7,
    //  name: Ujjawal Maurya,
    //  email: chocolateboyz0011@gmail.com,
    //  mobile: 85887878,
    //  password: $2a$10$5LBYeRtceHZk5O8wYmlgqOQYu0SZPbULblIlOoPX494Ex4N2pOuJK,
    //  role: STORE_MANAGER,
    //  businessDetails: [],
    //  businessId: 1,
    //  active: true }
    log("================== Success ===================");

    switch (_bodyData["role"]) {
      case 'SALESMAN':
        Get.offAllNamed('/SALESMAN');
        break;
      case 'STORE_MANAGER':
        Get.offAllNamed('/STORE_MANAGER');
        break;
      case 'STORE_OWNER':
        Get.offAllNamed('/STORE_OWNER');
        break;
      case 'ADMIN':
        Get.offAllNamed('/ADMIN');

        break;
      default:
        Get.offAllNamed('/login');
    }
  } else {
    notifyUser(context, "${_bodyData["message"]}");
  }
  // }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Text("Paperlessly", style: Theme.of(context).textTheme.displayMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text("Point of Sale", style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _userController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_4_sharp),
                        hintText: "Email or Username",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: isObscured,
                      controller: _passController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password_sharp),
                        // counter: Text(_userController.text.length.toString()),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            isObscured = !isObscured;
                          }),
                          icon: Icon(isObscured ? Icons.remove_red_eye : Icons.elderly_sharp),
                        ),
                        hintText: "Password",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 35),
                      height: 50,
                      width: 280,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Navigate the user to the Home page
                            login(context);
                          } else {
                            notifyUser(context, 'Please fill input');
                          }
                        },
                        child: const Text(
                          "Login to continue",
                          // style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//? sign-up Req

// {
//   "email": "user1",
//   "password":"TestPass#2",
//   "role": "STORE_MANAGER",
//   "mobile": "9129734440",
//   "name": "Ujjawalll",
//   "email": "chocolateboyz0011@gmail.com"
// }

// {
//     "verifyToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjaG9jb2xhdGVib3l6MDAxMUBnbWFpbC5jb20iLCJyb2xlIjoiU1RPUkVfT1dORVIiLCIkb3RwIjoiXHUwMDA0Xllqb0HDvmxcdTAwMTbDmMKAT0nCpikuIiwiZXhwIjoxNjkyMDAyMjU1LCJ1dWlkIjoiNmYwNGJhNGItZjdiMi00NDk5LTljNmMtOTc2ZGM2ZjdkMDdmIiwiaWF0IjoxNjkyMDAxOTU1LCJUb2tlbl90eXBlIjoidmVyaWZ5VG9rZW4iLCJlbWFpbCI6ImNob2NvbGF0ZWJveXowMDExQGdtYWlsLmNvbSJ9.Q4RAvVoilwJYsd1svNLr6MzNQjZSsLRyA8h0fIWuaf0",
//     "message": "OTP has been sent to chocolateboyz0011@gmail.com"
// }

//? Signup body res
// {
//     "id": 4,
//     "name": "Ujjawalll",
//     "email": "chocolateboyz0011@gmail.com",
//     "mobile": "9129734440",
//     "password": "$2a$10$HdGsTPl9vrQWvh3NH3QgiOO4MU74CIYQ2CirYNqn3W4pLgBOGus1W",
//     "role": "STORE_OWNER",
//     "businessDetails": null,
//     "createdAt": "2023-08-14T08:32:34.715+00:00",
//     "updatedAt": "2023-08-14T08:32:34.715+00:00",
//     "active": true
// }

//? Verify token
// eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjaG9jb2xhdGVib3l6MDAxMUBnbWFpbC5jb20iLCJyb2xlIjoiU1RPUkVfT1dORVIiLCIkb3RwIjoiXHUwMDA0Xllqb0HDvmxcdTAwMTbDmMKAT0nCpikuIiwiZXhwIjoxNjkyMDAyMjU1LCJ1dWlkIjoiNmYwNGJhNGItZjdiMi00NDk5LTljNmMtOTc2ZGM2ZjdkMDdmIiwiaWF0IjoxNjkyMDAxOTU1LCJUb2tlbl90eXBlIjoidmVyaWZ5VG9rZW4iLCJlbWFpbCI6ImNob2NvbGF0ZWJveXowMDExQGdtYWlsLmNvbSJ9.Q4RAvVoilwJYsd1svNLr6MzNQjZSsLRyA8h0fIWuaf0
