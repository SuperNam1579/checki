import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/home_provider.dart';
import 'pages/attendance/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ เพิ่มบรรทัดนี้เพื่อโหลดข้อมูลภาษาสำหรับ DateFormat
  await initializeDateFormatting('th_TH', null);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Check-in App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
