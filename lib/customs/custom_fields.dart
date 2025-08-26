import 'package:flutter/material.dart';
import 'package:washmen/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? icon;
  final String? imagePath;
  final bool obscureText;
  final bool showVisibilityIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final bool isSignUpStyle;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.icon,
    this.imagePath,
    this.obscureText = false,
    this.showVisibilityIcon = false,
    this.keyboardType,
    this.onChanged,
    this.controller,
    this.validator,
    this.contentPadding,
    this.height,
    this.isSignUpStyle = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSignUpStyle) {
      return _buildSignUpTextField();
    }
    return _buildLoginTextField();
  }

  Widget _buildLoginTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.appColor, width: 1.0),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              prefixIcon:
                  widget.icon != null
                      ? Icon(widget.icon, size: 20, color: AppColors.appColor)
                      : (widget.imagePath != null
                          ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              widget.imagePath!,
                              width: 20,
                              height: 20,
                            ),
                          )
                          : null),
              suffixIcon:
                  widget.showVisibilityIcon
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : null,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
              border: InputBorder.none,
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(vertical: 15),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: widget.height ?? 48,
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              prefixIcon:
                  widget.icon != null
                      ? Icon(widget.icon, size: 20, color: AppColors.appColor)
                      : null,
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
              filled: true,
              fillColor: AppColors.bgColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.appColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.appColor),
              ),
              suffixIcon:
                  widget.showVisibilityIcon
                      ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
