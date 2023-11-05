import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/widgets/notify_snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "password",
                ),
                obscureText: true,
                // obscuringCharacter: 'o',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  notifyUser(context, 'signup action');
                },
                icon: const Icon(Icons.upcoming),
                label: const Text("Sign up"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
