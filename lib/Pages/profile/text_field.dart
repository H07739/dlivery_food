import 'package:flutter/material.dart';

import '../../color.dart';

class TextFieldEdit extends StatefulWidget {
  TextFieldEdit({
    super.key,
    required this.hintTextField,
    required this.hintText,
    this.heightTop = 15,
    this.heightBottom = 15,
    this.colorText = Colors.black54,
    this.colorTextField = Colors.grey,
    this.textInputType = TextInputType.text,
    required this.textEditingController,
  });

  final String hintTextField;
  final String hintText;
  final double heightTop;
  final double heightBottom;
  final Color colorTextField;
  final Color colorText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  @override
  State<TextFieldEdit> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.heightTop),
          Text(
            widget.hintText,
            style: TextStyle(
              color: widget.colorText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: widget.heightBottom),
          TextField(
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: secondary,
                  width: 2,
                ),
              ),
              hintText: widget.hintTextField,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          SizedBox(height: widget.heightBottom),
        ],
      ),
    );
  }
}
