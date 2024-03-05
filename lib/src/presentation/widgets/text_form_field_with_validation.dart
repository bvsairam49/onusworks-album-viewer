import 'package:flutter/material.dart';

class TextFormFieldWithValidation extends StatefulWidget {
  const TextFormFieldWithValidation({
    required this.controller,
    required this.labelText,
    this.isSecureField = false,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isSecureField;

  @override
  State<TextFormFieldWithValidation> createState() =>
      _TextFormFieldWithValidationState();
}

class _TextFormFieldWithValidationState
    extends State<TextFormFieldWithValidation> {
  late String _errorText;
  late bool _showPassword;
  @override
  void initState() {
    super.initState();
    _errorText = '';
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isSecureField ? !_showPassword : false,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.grey.shade800,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(
            widget.isSecureField ? Icons.lock_rounded : Icons.person_rounded,
            size: 24,
            color: Colors.grey.shade100,
          ),
          errorText: _errorText,
          errorStyle: const TextStyle(color: Colors.red),
          suffixIcon: widget.isSecureField
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade100,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
        ),
        validator: _validateText,
      ),
    );
  }

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter vaid input text';
    }
    if (widget.isSecureField && value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
