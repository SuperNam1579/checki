import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/auth/login_page.dart';
import 'pages/attendance/home_page.dart';
import 'pages/auth/register_page.dart';

void main() {
  runApp(const CheckInApp());
}

class CheckInApp extends StatelessWidget {
  const CheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ระบบเช็คชื่อ',

     theme: ThemeData(
  textTheme: GoogleFonts.kanitTextTheme(), // ✅ ใช้ฟ้อน Kanit ทั้งแอป
),

      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
