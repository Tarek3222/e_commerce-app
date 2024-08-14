import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hintText,  this.onChanged, this.validator, this.obscureText = false, this.maxLines=1, this.label, this.inputType, this.suffixIcon, });
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final int? maxLines;
  final String? label;
  final TextInputType? inputType;
  final IconButton? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            keyboardType: inputType,
            cursorColor: Colors.grey,
            obscureText: obscureText!,
            validator: validator,
            onChanged: onChanged ,
            maxLines:maxLines ,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              suffixIcon:suffixIcon ,
              hintText: hintText,
              hintStyle:const TextStyle(
                color: kPrimaryColor,
              ),
              labelText: label,
              errorStyle:const TextStyle(color: Colors.red,),
              labelStyle:const TextStyle(color: kPrimaryColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(color:  kPrimaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(color: kPrimaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(color:  Colors.red),
              ),
            ),
          );
  }
}