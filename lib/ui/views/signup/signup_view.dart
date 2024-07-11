import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  SignupViewModel viewModelBuilder(BuildContext context) => SignupViewModel();

  @override
  Widget builder(BuildContext context, SignupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'lib/resources/images/register.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Center(
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 58, 66, 86),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: const TextStyle(fontSize: 14),
                              prefixIcon: const Icon(Icons.person, size: 20),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.fromLTRB(12, 12, 64, 12),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              errorText: viewModel.firstNameError && viewModel.submitted ? 'First Name is required' : null,
                            ),
                            controller: viewModel.firstNameController,
                            onChanged: (value) {
                              viewModel.setFirstName(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: const TextStyle(fontSize: 14),
                              prefixIcon: const Icon(Icons.person, size: 20),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.fromLTRB(12, 12, 64, 12),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              errorText: viewModel.lastNameError && viewModel.submitted ? 'Last Name is required' : null,
                            ),
                            controller: viewModel.lastNameController,
                            onChanged: (value) {
                              viewModel.setLastName(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(fontSize: 14),
                              prefixIcon: const Icon(Icons.email, size: 20),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.fromLTRB(12, 12, 64, 12),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              errorText: viewModel.emailError != null && viewModel.submitted ? viewModel.emailError : null,
                            ),
                            onChanged: (value) {
                              viewModel.setEmail(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(fontSize: 14),
                              prefixIcon: const Icon(Icons.lock, size: 20),
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.fromLTRB(12, 12, 64, 12),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  viewModel.togglePasswordVisibility();
                                },
                                child: Icon(
                                  viewModel.obscureText ? Icons.visibility_off : Icons.visibility,
                                  size: 20,
                                ),
                              ),
                              errorText: viewModel.passwordError != null && viewModel.submitted ? viewModel.passwordError : null,
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
                            : ElevatedButton(
                                onPressed: () async {
                                  await viewModel.register();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.navigationService.back();
                              },
                              child: const Text(
                                "Login here",
                                style: TextStyle(fontSize: 14, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
