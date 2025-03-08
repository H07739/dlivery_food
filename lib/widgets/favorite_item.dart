import 'package:flutter/material.dart';

class FavoriteItem extends StatefulWidget {
  FavoriteItem({super.key,required this.like,required this.onPressed});
  bool like = false;
  Function(bool) onPressed;
  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      setState(() {
        widget.like = !widget.like;
      });
      widget.onPressed(widget.like);
    }, icon: widget.like?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.black,));
  }
}
