
import 'package:car_o_zone/firebase_options.dart';
import 'package:car_o_zone/screens/firebase/auth/splash_screen.dart';
import 'package:car_o_zone/screens/hive/model/car_comparison.dart';
import 'package:car_o_zone/screens/hive/model/comment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox('commentbox');

  Hive.registerAdapter(CarComparisonAdapter());
  await openHiveBoxes();
  runApp(const MyApp());
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<CarComparison>('car_comparison');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'carOzone',
      home: SplashScreen(),
    );
  }
}
