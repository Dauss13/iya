import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/AccountController.dart';
import 'package:mikan/view/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  final AccountController accountController = Get.put(AccountController());
  RxBool registerSuccess = false.obs;
  Account? account;

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }

  Future<void> registerAppwrite(
      String email, String password, String name) async {
    try {
      isLoading.value = true;
      final result = await accountController.createAccount({
        'userId': ID.unique(),
        'email': email,
        'password': password,
        'name': name,
      });
      print(result);
      Get.snackbar(
        'Success',
        'Registration successful',
        backgroundColor: Colors.green,
      );
      Get.offAll(LoginPage()); //Navigate login page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }


  void logOut() async {
    await _auth.signOut();
    Get.snackbar('Success', 'Logout Successful', backgroundColor: Colors.green);
    _prefs.remove('user_token');
    isLoggedIn.value = false;
    _auth.signOut();
    Get.offAllNamed('/login');
  }
}
