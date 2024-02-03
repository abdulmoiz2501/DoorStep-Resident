import 'package:flutter/material.dart';
import 'package:project/services/provider.dart';
import 'package:project/themes/dark_theme.dart';
import 'package:project/themes/light_theme.dart';
import 'package:project/ui/auth_page.dart';
import 'package:project/ui/change_password.dart';
import 'package:project/ui/edit_profile_page.dart';
import 'package:project/ui/filling_profile_details.dart';
import 'package:project/ui/generate_qr.dart';
import 'package:project/ui/home/home_page.dart';
import 'package:project/ui/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/ui/profile_page.dart';
import 'package:project/ui/settings_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'ui/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: lightTheme,
      //darkTheme: darkTheme,
      home:  AuthPage(),
      routes: {
        '/login': (context) =>  LoginPage(onSignUpClicked: (){}),
        '/onboarding': (context) =>  Onboarding(),
        '/auth': (context) =>  AuthPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) =>  ProfilePage(),
        '/editProfile': (context) =>  EditProfilePage(),
        '/fillProfile': (context) =>  FillProfilePage(),
        '/settings': (context) =>  SettingsPage(),
        '/changePassword': (context) =>  ChangePassword(),
        '/qrCodePage': (context) =>  QRCodePage(),
      }
    );
  }
}

