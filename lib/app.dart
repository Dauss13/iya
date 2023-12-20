import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/view/pages/home_page.dart';
import 'package:mikan/view/pages/login_page.dart';
import 'package:mikan/view/pages/settings_page.dart';
import 'package:mikan/view/pages/webview_page.dart';
import 'package:mikan/view/pages/register_page.dart';
import 'package:mikan/controller/auth_controller.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      initialRoute: _authController.isLoggedIn.value?'/home':'/login',
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsPage(),
        ),
        GetPage(name: '/bookmark', 
        page: () => BookWebView()
        ),
        GetPage(name: '/register', 
        page: () => RegisterPage()
        ),
        GetPage(name: '/login', 
        page: () => LoginPage()
        ),
      ],
    );
  }
}
