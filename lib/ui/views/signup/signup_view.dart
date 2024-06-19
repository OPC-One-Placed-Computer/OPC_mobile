import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();

  @override
  Widget builder(
      BuildContext context, SignupViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
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
                    // "Sign Up" text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // First name field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (value) {
                          // Handle first name change
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Last name field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (value) {
                          // Handle last name change
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Email field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        onChanged: (value) {
                          viewModel.setEmail(value);
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
                              viewModel.togglePasswordVisibility();
                            },
                            child: Icon(
                              viewModel.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        obscureText: viewModel.obscureText,
                        onChanged: (value) {
                          viewModel.setPassword(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    viewModel.isBusy
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjusted padding
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Button Tested'),
                                  ),
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Text for "Already have an account" and "Login here"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login screen
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Login here",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
