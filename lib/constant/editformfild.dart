import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTextfild extends StatelessWidget {
  final TextEditingController controller;
  // late String? validator;
  late String? hint;
  late Icon? prefixicon;
  late Widget? suffixicon;
  late int? number;
  late Widget? suffix;
  late String? Function(String?)? onsaved;
  late EdgeInsets? padding;
  late InputBorder? Border;
  late TextInputAction? textinput;
  late bool passwordshow;
  late TextInputType? keybordtype;
  late String? Function(String?)? validator;

  EditTextfild(
      {Key? key,
      required this.controller,
      this.validator,
      this.hint,
      this.prefixicon,
      this.suffix,
      this.padding,
      this.passwordshow = true,
      this.onsaved,
      this.textinput,
      this.Border,
      this.keybordtype,
      this.number,
      this.suffixicon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !passwordshow,
      inputFormatters: [
        LengthLimitingTextInputFormatter(number),
      ],
      keyboardType: keybordtype,
      textInputAction: textinput,
      validator: validator,
      onSaved: onsaved,
      decoration: InputDecoration(
        enabledBorder: Border,
        focusedBorder: Border,
        contentPadding: padding,
        border: Border,
        hintText: hint,
        prefixIcon: prefixicon,
        suffixIcon: suffixicon,
        suffix: suffix,
      ),
    );
  }
}
