import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../controller/account/auth_controller.dart';
import '../../../shared/widgets/button/round_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            const SizedBox(
              height: 80.0,
            ),
            Container(
              height: 120.0,
              width: 120.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/uniqCast.png'),
                  alignment: Alignment.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "UniqCast",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Unique tv experience".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 80.0,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 19,
                          top: 11,
                          right: 15,
                        ),
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
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 11,
                          right: 15,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      onSaved: (v) =>
                          authController.passwordController.text = v!,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: SizedBox(
                        width: Get.width,
                        child: RoundedButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          fontSize: 18,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              authController.login();
                            }
                          },
                          text: "Sign In",
                          color: const Color(0xff036EA0),
                          backgroundColor: Colors.white,
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
      ),
    );
  }
}
