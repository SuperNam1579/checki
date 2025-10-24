import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();

  /// ✅ ฟังก์ชันเข้าสู่ระบบ (เรียกผ่าน AuthProvider → ApiService)
  void _login() async {
    final studentId = _studentIdController.text.trim();
    final password = _passwordController.text;

    if (studentId.isEmpty || password.isEmpty) {
      _showPopup('กรุณากรอกข้อมูลให้ครบถ้วน', Colors.redAccent);
      return;
    }

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(studentId, password);

      if (success) {
        _showPopup('เข้าสู่ระบบสำเร็จ', Colors.green);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        _showPopup('รหัสนิสิตหรือรหัสผ่านไม่ถูกต้อง', Colors.redAccent);
      }
    } catch (e) {
      _showPopup('เกิดข้อผิดพลาดในการเชื่อมต่อ', Colors.redAccent);
    }
  }

  /// ✅ Popup แสดงผลการเข้าสู่ระบบ
  void _showPopup(String message, Color color) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              color == Colors.green ? Icons.check_circle : Icons.error,
              color: color,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: GoogleFonts.kanit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A11CB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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

  /// ✅ ส่วน UI
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
                  child: Icon(Icons.lock_open, size: 40, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  "เข้าสู่ระบบ",
                  style: GoogleFonts.kanit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                _buildTextField(
                  _studentIdController,
                  "รหัสนิสิต",
                  "กรอกรหัสนิสิตของคุณ",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _passwordController,
                  "รหัสผ่าน",
                  "กรอกรหัสผ่านของคุณ",
                  isPassword: true,
                ),

                const SizedBox(height: 24),
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

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
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

  /// ✅ ฟังก์ชันสร้าง TextField
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: _inputDecoration(label, hint),
      style: GoogleFonts.kanit(color: Colors.white),
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
