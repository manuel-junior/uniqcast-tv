import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../controller/controller.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.isLoading,
    required this.authController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final RxBool isLoading;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 450.0,
      ),
      width: Get.width,
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff036EA0),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              isLoading.value = true;

              await Future.delayed(const Duration(seconds: 2), () {});
              bool response = await authController.login();
              if (response == false) {
                isLoading.value = false;
              }
            }
          },
          child: isLoading.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kPrimaryColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Please wait...")
                  ],
                )
              : const Text("Sign In"),
        ),
      ),
    );
  }
}
