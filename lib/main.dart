import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikan/app.dart';
import 'package:mikan/controller/DatabaseCotroller.dart';
import 'package:mikan/firebase_options.dart';
import 'package:mikan/notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //shared preferences
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  //background & terminated notification
  await FirebaseMessagingHandler().initPushNotificaton();
  //foreground notififaction
  await FirebaseMessagingHandler().initLocalNotification();
  Get.put(DatabaseController());
  runApp(MyApp());
}
