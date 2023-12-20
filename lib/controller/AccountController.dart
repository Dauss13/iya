import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:mikan/controller/ClientController.dart';
import 'package:flutter/material.dart';

class AccountController extends ClientController {
   RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  Account? account;
  @override
  void onInit() {
    super.onInit();
// appwrite
    account = Account(client);
  }

  Future createAccount(Map map) async {
    try {
      final result = await account!.create(
        userId: map['userId'],
        email: map['email'],
        password: map['password'],
        name: map['name'],
      );
      print("AccountController:: createAccount $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Account",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future createEmailSession(Map<String, dynamic> map) async {
    try {
      final result = await account!.createEmailSession(
        email: map['email'],
        password: map['password'],
      );
      print("AccountController:: createEmailSession $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Account",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      final result = await account!.createEmailSession(
        email: email, 
        password: password

      );
      Get.snackbar('Success', 'Login Successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } catch (error) {
      Get.snackbar('Error', 'Login failed $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
  
}