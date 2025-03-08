import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/category_model.dart';
import 'package:my_project/color.dart';

class Selectedcategory extends StatefulWidget {
  Selectedcategory(
      {super.key, required this.onSelected, required this.categorys});
  Function(int index) onSelected;
  List<CategoryModel> categorys;
  int _selected = 0;

  @override
  State<Selectedcategory> createState() => _SelectedcategoryState();
}

class _SelectedcategoryState extends State<Selectedcategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // الارتفاع الكلي للعناصر
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // ✅ جعل القائمة أفقية
        itemCount: widget.categorys.length,
        itemBuilder: (context, index) {
          bool isSelected = widget._selected == index;

          // قياس عرض النص
          TextPainter textPainter = TextPainter(
            text: TextSpan(
              text: widget.categorys[index].name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            maxLines: 2, // ✅ جعل النص ينزل لسطر جديد عند الحاجة
            textDirection: TextDirection.ltr,
          )..layout();

          double textWidth = textPainter.width;
          double containerWidth = textWidth.clamp(100, 200); // ✅ تحديد عرض الصورة والنص بين 100 و 200

          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget._selected = index;
                });
                widget.onSelected(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      widget.categorys[index].image,
                      fit: BoxFit.cover,
                      height: 120, // ✅ ارتفاع الصورة ثابت
                      width: containerWidth, // ✅ عرض الصورة يعتمد على عرض النص
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                  Container(
                    width: containerWidth, // ✅ جعل عرض النص مطابقًا للصورة
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: isSelected ? kprimaryColor : Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,

                    child: Text(
                      widget.categorys[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2, // ✅ السماح بالنزول لسطر جديد
                      overflow: TextOverflow.visible, // ✅ إظهار النص بالكامل
                      softWrap: true, // ✅ تمكين الالتفاف التلقائي
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );


  }

}
