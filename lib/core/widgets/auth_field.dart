import 'package:flutter/material.dart';
import 'package:my_messaging/constants/constants.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _isObscure;
  @override
  void initState() {
    _isObscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: FontSize.medium),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; // Toggle visibility
                    });
                  },
                )
                : null,
      ),
      obscureText: _isObscure,
    );
  }
}
