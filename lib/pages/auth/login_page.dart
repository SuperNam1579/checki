import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // ตอนนี้ยังไม่มี API ก็จำลองไว้ก่อน
    _showLoginSuccessPopup(context);
  }

  void _showLoginSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text(
              'เข้าสู่ระบบสำเร็จ!',
              style: GoogleFonts.kanit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A11CB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('ตกลง', style: GoogleFonts.kanit(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, size: 40, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  "เช็คชื่อ",
                  style: GoogleFonts.kanit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "ระบบเช็คชื่อออนไลน์",
                  style: GoogleFonts.kanit(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 40),

                // ช่องกรอกอีเมล
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "อีเมล",
                    hintText: "กรอกอีเมลของคุณ",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelStyle: GoogleFonts.kanit(color: Colors.white),
                    hintStyle: GoogleFonts.kanit(color: Colors.white70),
                  ),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                SizedBox(height: 16),

                // ช่องกรอกรหัสผ่าน
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "รหัสผ่าน",
                    hintText: "กรอกรหัสผ่าน",
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelStyle: GoogleFonts.kanit(color: Colors.white),
                    hintStyle: GoogleFonts.kanit(color: Colors.white70),
                  ),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                SizedBox(height: 24),

                // ปุ่มเข้าสู่ระบบ
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: GoogleFonts.kanit(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/register',
                    ); // ✅ ไปหน้า Register
                  },
                  child: Text(
                    "ยังไม่มีบัญชี? สมัครสมาชิก",
                    style: GoogleFonts.kanit(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
