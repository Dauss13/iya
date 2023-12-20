import 'package:get/get.dart';
import 'dart:io';

class SettingsController extends GetxController {
  final RxString _userName = 'MikanMabo'.obs;
  final RxString _userEmail = 'MikanMabo@email.com'.obs;
  Rx<File?> profilePicture = Rx<File?>(null);

  // Getter for user name
  String get userName => _userName.value;

  // Setter for user name
  set userName(String value) => _userName.value = value;

  // Getter for user email
  String get userEmail => _userEmail.value;

  // Setter for user email
  set userEmail(String value) => _userEmail.value = value;

  void updateProfilePicture(File imageFile) {
    profilePicture.value = imageFile;
  }
}
