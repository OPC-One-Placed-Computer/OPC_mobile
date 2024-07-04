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
        body: Container(
          color: const Color.fromARGB(255, 19, 7, 46),
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/resources/images/logo.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                Center(
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                        ),
                        const SizedBox(height: 0),
                        const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              model.setEmail(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
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
                        const SizedBox(height: 20),
                        model.isBusy
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    bool loginSuccess = await model.login();
                                    if (loginSuccess) {
                                      model.navigationService
                                          .navigateTo(Routes.products);
                                    }
                                  },
                                  child: const Text('Login'),
                                ),
                              ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/password_recovery');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.navigationService
                                    .navigateTo(Routes.signup);
                              },
                              child: const Text(
                                "Register here",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
