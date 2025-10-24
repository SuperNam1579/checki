import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  void _register() {
    // ตอนนี้ยังไม่มี API – จำลองการสมัครสมาชิก
    if (_passwordController.text != _confirmController.text) {
      _showPopup("รหัสผ่านไม่ตรงกัน", Colors.redAccent);
      return;
    }

    _showPopup("สมัครสมาชิกสำเร็จ!", Colors.green);
  }

  void _showPopup(String message, Color color) {
    showDialog(
      context: context, // ✅ ต้องใช้ context ตรงนี้
      builder: (context) => AlertDialog(
        // ✅ ไม่ใช้ (_) แล้ว
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: color, size: 60),
            const SizedBox(height: 16),
            Text(
              message,
              style: GoogleFonts.kanit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (color == Colors.green) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
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
                  child: Icon(Icons.person_add, size: 40, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  "สมัครสมาชิก",
                  style: GoogleFonts.kanit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // ชื่อ
                TextField(
                  controller: _nameController,
                  decoration: _inputDecoration(
                    "ชื่อ-นามสกุล",
                    "กรอกชื่อของคุณ",
                  ),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                const SizedBox(height: 16),
                // รหัสนิสิต
                TextField(
                  controller: _studentIdController,
                  decoration: _inputDecoration(
                    "รหัสนิสิต",
                    "กรอกรหัสนิสิตของคุณ",
                  ),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                const SizedBox(height: 16),
                // อีเมล
                TextField(
                  controller: _emailController,
                  decoration: _inputDecoration("อีเมล", "กรอกอีเมลของคุณ"),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // รหัสผ่าน
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration("รหัสผ่าน", "ตั้งรหัสผ่าน"),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                const SizedBox(height: 16),

                // ยืนยันรหัสผ่าน
                TextField(
                  controller: _confirmController,
                  obscureText: true,
                  decoration: _inputDecoration(
                    "ยืนยันรหัสผ่าน",
                    "พิมพ์รหัสผ่านอีกครั้ง",
                  ),
                  style: GoogleFonts.kanit(color: Colors.white),
                ),
                const SizedBox(height: 24),

                // ปุ่มสมัครสมาชิก
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "สมัครสมาชิก",
                      style: GoogleFonts.kanit(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "มีบัญชีอยู่แล้ว? เข้าสู่ระบบ",
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

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      labelStyle: GoogleFonts.kanit(color: Colors.white),
      hintStyle: GoogleFonts.kanit(color: Colors.white70),
    );
  }
}
