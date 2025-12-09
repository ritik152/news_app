import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/services/firebase/firebase_services.dart';
import 'modules/news/news_controller.dart';
import 'modules/news/news_view.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Get.put(NewsController());

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    FirebaseServices.init(context).then((value){
      FirebaseServices.listener();
    });
    checkInitialMessage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NewsView(),
    );
  }

  void checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final route = initialMessage.data['route'];
      if (route != null) {

      }
    }
  }
}

