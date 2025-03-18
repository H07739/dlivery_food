import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  ImageView({super.key,this.height,this.width,required this.url});
  double? height;
  double? width;
  String url;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url,
      fit: BoxFit.cover,
      height: widget.height,
      width: widget.width,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return GestureDetector(
          onTap: () =>
              setState(() {

              }),
          child: Container(
              color: Colors.red,
              child: Center(child: Icon(Icons.refresh, color: Colors.white,),)),
        );
      },
    );
  }
}
