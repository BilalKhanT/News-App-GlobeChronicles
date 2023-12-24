import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/saved_provider.dart';
import 'package:news_app/screens/sidemenu.dart';
import 'package:news_app/screens/splash.dart';
import 'package:news_app/screens/splash2.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;
  String? username;

  @override
  void initState() {
    super.initState();
    checkIfLogin();
  }

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
          username = user.email;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SavedProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Globe',
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
        home: isLogin ? SplashScreenLogin(userName: username!): SplashScreen(),
      ),
    );
  }
}


