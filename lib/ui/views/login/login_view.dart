import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(''),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                Center(
                  // Center horizontally
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Card header with OPC title
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              'OPC',
                              style: TextStyle(
                                fontSize: 70.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40), // Reduced height
                        // "Sign In" text
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Email field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            onChanged: (value) {
                              model.setEmail(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  model.togglePasswordVisibility();
                                },
                                child: Icon(
                                  model.obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            obscureText: model.obscureText,
                            onChanged: (value) {
                              model.setPassword(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        model.isBusy
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    bool success = await model.login();
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Login Successful'),
                                        ),
                                      );
                                      // Navigate to /products route
                                      Navigator.of(context)
                                          .pushReplacementNamed('/products');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Invalid Credentials'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Login'),
                                ),
                              ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                // Password recovery link
                TextButton(
                  onPressed: () {
                    // Navigate to password recovery screen
                    Navigator.pushNamed(context, '/password_recovery');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 0),
                // Text for "Don't have an account" and "Register here"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration screen
                        model.navigationService.navigateTo(Routes.signup);
                      },
                      child: const Text(
                        "Register here",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
