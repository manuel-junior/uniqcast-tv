import 'package:flutter/material.dart';

enum InputType {
  password,
  email,
}

class CustomTxtInput extends StatelessWidget {
  const CustomTxtInput({
    Key? key,
    required this.inputController,
    required GlobalKey<FormState> formKey,
    required this.hintText,
    required this.inputType,
  })  : _formKey = formKey,
        super(key: key);

  final TextEditingController inputController;
  final GlobalKey<FormState> _formKey;
  final String hintText;
  final InputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 450.0,
      ),
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
            left: 15,
            bottom: 11,
            top: 11,
            right: 15,
          ),
        ),
        keyboardType: inputType == InputType.email
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        obscureText: inputType == InputType.email ? false : true,
        textInputAction: TextInputAction.next,
        onChanged: (String? value) {
          _formKey.currentState!.validate();
        },
        validator: (v) {
          if (v == null || v.isEmpty) {
            return '$hintText is required';
          }
          return null;
        },
        onSaved: (v) => inputController.text = v!,
      ),
    );
  }
}
