import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/providers/user_provider.dart';
import 'package:flutter_instagram/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram/responsive/responsive_layout.dart';
import 'package:flutter_instagram/responsive/web_screen_layout.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDOEjktIYchfIVM4Z_OKJExYVgHuGWR13c',
            appId: '1:954122071176:web:24e6398fde3a04d234833d',
            messagingSenderId: '954122071176',
            projectId: 'flutter-firebase-course-20c1a',
            storageBucket: 'flutter-firebase-course-20c1a.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Instagram',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  print(snapshot.connectionState);
                  // Checking if the snapshot has any data or not
                  if (snapshot.hasData) {
                    // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                // means connection to future hasnt been made yet
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return const LoginScreen();
              })),
    );
  }
}
