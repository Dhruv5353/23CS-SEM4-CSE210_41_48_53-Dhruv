// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/splash.dart';
// import 'package:flutter_application_1/home_screen.dart';
// import 'package:flutter_application_1/student_profile.dart';
// import 'package:flutter_application_1/faculty_profile.dart';
// import 'package:flutter_application_1/register.dart';
// import 'package:flutter_application_1/login.dart';
// import 'package:flutter_application_1/faculty_home.dart';
// import 'package:flutter_application_1/student_home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'The Edu Venture',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const SplashScreen(),
//       routes: {
//         'home': (context) => const HomeScreen(),
//         'student_profile': (context) => const StudentProfile(),
//         'faculty_profile': (context) => const FacultyProfile(),
//         'register': (context) => const MyRegister(),
//         'login': (context) => const MyLogin(),
//       },
//     );
//   }
// }

//import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/splash.dart';
// import 'package:flutter_application_1/student_profile.dart';
// import 'package:flutter_application_1/faculty_profile.dart';
// import 'package:flutter_application_1/register.dart';
// import 'package:flutter_application_1/login.dart';
// import 'package:flutter_application_1/faculty_home.dart';
// import 'package:flutter_application_1/student_home.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
import 'package:flutter/material.dart';
import 'package:the_eduventure/splash.dart';
import 'package:the_eduventure/student_profile.dart';
import 'package:the_eduventure/faculty_profile.dart';
import 'package:the_eduventure/register.dart';
import 'package:the_eduventure/login.dart';
import 'package:the_eduventure/faculty_home.dart';
import 'package:the_eduventure/student_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Edu Venture',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      routes: {
        'login': (context) => const MyLogin(),
        'register': (context) => const MyRegister(),
        'student_home': (context) => const StudentHome(),
        'faculty_home': (context) => const FacultyHome(),
        'student_profile': (context) => const StudentProfile(),
        'faculty_profile': (context) => const FacultyProfile(),
      },
    );
  }
}
