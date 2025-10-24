import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';

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

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final studentId = _studentIdController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (name.isEmpty ||
        studentId.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      _showPopup("กรอกข้อมูลให้ครบทุกช่อง", Colors.redAccent);
      return;
    }

    if (password != confirm) {
      _showPopup("รหัสผ่านไม่ตรงกัน", Colors.redAccent);
      return;
    }

    try {
      final response = await ApiService.register({
        'device_id': 'flutter_app_001',
        'student_id': studentId,
        'name': name,
        'email': email,
        'password': password,
        'rePassword': confirm,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _showPopup("สมัครสมาชิกสำเร็จ!", Colors.green);
      } else {
        _showPopup(data['message'] ?? "สมัครไม่สำเร็จ", Colors.redAccent);
      }
    } catch (e) {
      _showPopup("เกิดข้อผิดพลาดในการเชื่อมต่อเซิร์ฟเวอร์", Colors.redAccent);
    }
  }

  void _showPopup(String message, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                fontSize: 20,
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
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1,
                  size: 70, color: Color(0xFF1976D2)),
              const SizedBox(height: 20),
              Text(
                "สมัครสมาชิก",
                style: GoogleFonts.kanit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 40),

              _buildTextField(_nameController, "ชื่อ-นามสกุล", "กรอกชื่อของคุณ"),
              const SizedBox(height: 16),
              _buildTextField(
                  _studentIdController, "รหัสนิสิต", "กรอกรหัสนิสิตของคุณ"),
              const SizedBox(height: 16),
              _buildTextField(_emailController, "อีเมล", "กรอกอีเมลของคุณ"),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, "รหัสผ่าน", "ตั้งรหัสผ่าน",
                  isPassword: true),
              const SizedBox(height: 16),
              _buildTextField(_confirmController, "ยืนยันรหัสผ่าน",
                  "พิมพ์รหัสผ่านอีกครั้ง",
                  isPassword: true),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                  ),
                  child: Text("สมัครสมาชิก",
                      style: GoogleFonts.kanit(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: Text(
                  "มีบัญชีอยู่แล้ว? เข้าสู่ระบบ",
                  style: GoogleFonts.kanit(
                    color: const Color(0xFF1976D2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      String hint, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: _inputDecoration(label, hint),
      style: GoogleFonts.kanit(color: Colors.black87),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: GoogleFonts.kanit(color: const Color(0xFF0D47A1)),
      hintStyle: GoogleFonts.kanit(color: const Color(0xFF90A4AE)),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
      ),
    );
  }
}
