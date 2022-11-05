import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userinfo/controller/fire_controller.dart';

import 'firebase_options.dart';
import 'pages/user_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.delayed(const Duration(seconds: 1));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<FireController>(() => FireController(), fenix: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserForm(),
    );
  }
}
