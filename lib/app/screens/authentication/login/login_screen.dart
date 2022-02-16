import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../controller/account/auth_controller.dart';
import '../../../shared/widgets/widgets.dart';

import 'widgets/log_in_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  final RxBool isLoading = false.obs;

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
            const SizedBox(
              height: 2.5,
            ),
            Text(
              "Unique tv experience".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 80.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTxtInput(
                      inputController: authController.userController,
                      formKey: _formKey,
                      hintText: 'Username',
                      inputType: InputType.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTxtInput(
                      inputController: authController.passwordController,
                      formKey: _formKey,
                      hintText: 'Password',
                      inputType: InputType.password,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    LogInButton(
                      formKey: _formKey,
                      isLoading: isLoading,
                      authController: authController,
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
