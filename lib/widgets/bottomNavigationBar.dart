import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:my_project/color.dart';

class BottomnavigationbarX extends StatefulWidget {
  BottomnavigationbarX({super.key,required this.index});
  Function(int index) index;
  @override
  State<BottomnavigationbarX> createState() => _BottomnavigationbarXState();
}

class _BottomnavigationbarXState extends State<BottomnavigationbarX> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconSize: 28,
      currentIndex: selectedIndex,
      selectedItemColor: kprimaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        color: kprimaryColor,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
        widget.index(selectedIndex);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart,
          ),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar,
          ),
          label: "Meal Plan",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 3 ? Icons.person:Icons.person_2_outlined,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}



class BottomnavigationbarAdmin extends StatefulWidget {
  BottomnavigationbarAdmin({super.key,required this.index});
  Function(int index) index;

  @override
  State<BottomnavigationbarAdmin> createState() => _BottomnavigationbarAdminState();
}

class _BottomnavigationbarAdminState extends State<BottomnavigationbarAdmin> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconSize: 28,
      currentIndex: selectedIndex,
      selectedItemColor: kprimaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        color: kprimaryColor,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
        widget.index(selectedIndex);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Icons.fastfood_sharp : Icons.fastfood_outlined,
          ),
          label: "Food",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 1 ? Iconsax.category : Iconsax.category1,
          ),
          label: "Category",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar,
          ),
          label: "Meal Plan",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2,
          ),
          label: "Setting",
        ),
      ],
    );
  }
}
