import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/mange_category/view/add_category.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Edit Your Profile'),
              trailing: IconButton(onPressed: (){}, icon: Transform.rotate(
                angle: 3.1416,
                child: Icon(Icons.arrow_back_ios,color: Colors.red,),
              )
              ),


            ),

            ListTile(
              onTap: ()=>Get.to(AddCategory()),
              leading: Icon(Icons.category,color: Colors.green,),
              title: Text('Add Category', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward),)
          ],
        ),
      ),
    );
  }
}
