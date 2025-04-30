import 'package:flutter/material.dart';

import '../../color.dart';
class TextFieldEdit extends StatefulWidget {
  TextFieldEdit({super.key,required this.hintTextField,required this.hintText,this.heightTop = 15,this.heightBottom = 15,this.colorText =Colors.black54,this.colorTextField = Colors.grey,this.textInputType =TextInputType.text,required this.textEditingController});
  String hintTextField;
  String hintText;
  double heightTop;
  double heightBottom;
  Color colorTextField;
  Color colorText;
  TextInputType textInputType;
  TextEditingController textEditingController;



  @override
  State<TextFieldEdit> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldEdit> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.heightTop,),
          Text(widget.hintText,style: TextStyle(color: widget.colorText),),
          SizedBox(height: widget.heightBottom,),
          TextField(
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              fillColor: widget.colorTextField,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:  BorderSide(
                  color: secondary,
                  width: 1,
                ),
              ),
              hintText: widget.hintTextField,
            ),
          ),
          SizedBox(height: widget.heightBottom,),
          const Divider(color: Colors.grey,)

        ],
      ),
    );
  }
}
