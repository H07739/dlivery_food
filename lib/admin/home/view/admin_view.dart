import 'package:flutter/material.dart';

import '../color.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Manger'),
        backgroundColor: kprimaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          MaterialButton(
            onPressed: () {},
            color: kBannerColor,
            child: Text('Manger Food',style: TextStyle(color: Colors.white),),
          ),
          MaterialButton(
            onPressed: () {},
            color: kBannerColor,
            child: Text('Manger Categoty',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
