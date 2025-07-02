import 'package:flutter/material.dart';

class LongTextFieldForm extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String labelText;
  final bool showSuffixIcon;
  final bool showPrefixIcon;
  final IconData? prefixIcon;
  final bool obsureText;
  final String? prefixText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  final bool isRed;

  const LongTextFieldForm(
      {super.key,
      this.controller,
      this.focusNode,
      this.hintText,
      required this.labelText,
      this.showSuffixIcon = false,
      this.showPrefixIcon = false,
      this.prefixText,
      this.prefixIcon,
      required this.validator,
      this.obsureText = false,
      this.isRed = false});

  @override
  State<LongTextFieldForm> createState() => _LongTextFieldFormState();
}

class _LongTextFieldFormState extends State<LongTextFieldForm> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      /// Todo: dont forget https://www.geeksforgeeks.org/how-to-hide-the-keyboard-when-user-tap-out-of-the-textfield-in-flutter/?ref=ml_lbp
      focusNode: widget.focusNode,
      validator: widget.validator,
      obscureText: widget.obsureText ? passwordVisible : false,
      controller: widget.controller,
      decoration: InputDecoration(
        focusedBorder: widget.isRed
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.purple,
                  width: 0.7,
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey, width: 0.7)),
        enabledBorder: widget.isRed
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.purple,
                  width: 0.7,
                ),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey, width: 0.7)),
        prefixIcon: widget.showPrefixIcon ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.showSuffixIcon
            ? IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(passwordVisible
                    ? Icons.visibility_off_sharp
                    : Icons.visibility_sharp),
              )
            : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixText: widget.prefixText,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple),
            borderRadius: BorderRadius.circular(20)),
      ),

      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }
}
