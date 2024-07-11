import 'package:flutter/material.dart';
import 'package:opc_mobile_development/app/app.router.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    'lib/resources/images/login.png',
                    height: 230,
                    width: 230,
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
                              'Sign In',
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
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: const Icon(Icons.email, size: 20),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                                  errorText: model.emailError != null && model.submitted ? model.emailError : null,
                                ),
                                onChanged: (value) {
                                  model.setEmail(value);
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
                                  filled: true,
                                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      model.togglePasswordVisibility();
                                    },
                                    child: Icon(
                                      model.obscureText ? Icons.visibility_off : Icons.visibility,
                                      size: 20,
                                    ),
                                  ),
                                  errorText: model.passwordError != null && model.submitted ? model.passwordError : null,
                                ),
                                obscureText: model.obscureText,
                                onChanged: (value) {
                                  model.setPassword(value);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            model.isBusy
                                ? const Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () async {
                                      model.login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.navigationService.navigateTo(Routes.signup);
                                  },
                                  child: const Text(
                                    "Register here",
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
        ),
      ),
    );
  }
}
