import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/account/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/uniqcast.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              height: 174.0,
              width: 174.0,
            ),
          ),
          const SizedBox(
            height: 81.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: authController.userController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    onSaved: (v) => authController.userController.text = v!,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: authController.passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onSaved: (v) => authController.passwordController.text = v!,
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 225,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            Get.theme.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authController.login();
                          }
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.9,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
