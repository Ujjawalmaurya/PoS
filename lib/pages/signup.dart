import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/services/apiServices.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';
import 'package:pos/src/widgets/pos_input_tile.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TextEditingController nameCtrl = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Form(
          // key: _key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Text("Register your Business", style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text("with", style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text("Paperlessly", style: Theme.of(context).textTheme.displayMedium),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text("Point of Sale", style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     decoration: const InputDecoration(
                //       hintText: "username",
                //     ),
                //   ),
                // ),
                PoSInputField(
                  hint: "Name",
                  label: "Full name",
                  controller: nameCtrl,
                ),
                PoSInputField(
                  label: "Mobile number",
                  hint: "Mobile",
                  maxLength: 10,
                  controller: mobCtrl,
                ),
                PoSInputField(
                  label: 'Email',
                  hint: "Email address",
                  controller: emailCtrl,
                ),
                PoSInputField(
                  label: "Password",
                  hint: "Password",
                  obscureText: true,
                  controller: passCtr,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // notifyUser(context, 'signup action');
                      var res =
                          await APIServices.signup(nameCtrl.text, emailCtrl.text, mobCtrl.text, passCtr.text);
                      var body = json.decode(res.body);
                      log("$body");
                      log("${body.runtimeType}");
                      body['type'] != 'error'
                          ? Get.toNamed(
                              '/otp',
                              arguments: {
                                'name': nameCtrl.text,
                                'email': emailCtrl.text,
                                'token': body['verifyToken'],
                              },
                              // FORMAT - arguments: {
                              //   'name': nameTxtController.text,
                              //   'email': emailTxtController.text,
                              //   'token': body['verifyToken'],
                              // },
                            )
                          : showSnackbar("ERROR", "${body['message']}");
                      // showSnackbar(body['type'], body['message']);
                    },
                    icon: const Icon(Icons.upcoming),
                    label: const Text("Sign up"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
