import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final RxInt _currentIndex = 0.obs;

  BottomNavBar({Key? key}) : super(key: key);

  void _onItemTapped(int index) {
    _currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed('/homePage');
        break;
      case 1:
        Get.offAllNamed('/register');
        break;
      case 2:
        Get.offAllNamed('/settings');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: _currentIndex.value,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black87,
      );
    });
  }
}
