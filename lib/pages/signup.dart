import 'package:flutter/material.dart';
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
        child: Form(
          // key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register your Business", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text("with", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text("Paperlessly", style: Theme.of(context).textTheme.displayMedium),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text("Point of Sale", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
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
      ),
    );
  }
}
