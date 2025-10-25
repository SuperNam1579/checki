import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/api_service.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _studentidController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final email = _studentidController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showPopup("กรอกรหัสนิสิตและรหัสผ่านให้ครบ", Colors.redAccent);
      return;
    }

    try {
      final deviceId = await getDeviceId();
      final response = await ApiService.login({
        'device_id': deviceId,
        'student_id': email,
        'password': password,
      });

      final data = jsonDecode(response.body);
      print("login data: $data");

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user_id", data["user"]["id"]);
        _showPopup("เข้าสู่ระบบสำเร็จ!", Colors.green);
      } else {
        _showPopup(data['message'] ?? "เข้าสู่ระบบไม่สำเร็จ", Colors.redAccent);
      }
    } catch (e) {
      print("error: $e");
      _showPopup("ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้", Colors.redAccent);
    }
  }

  // ✅ ดึง device_id จากเครื่อง (Android / iOS)
  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        // ✅ ใช้ androidId แทน id (รองรับ Android 10+)
        return androidInfo.id ??
            androidInfo.device ??
            androidInfo.model ??
            "unknown_android";
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? "unknown_ios";
      } else {
        return "unknown_device";
      }
    } catch (e) {
      debugPrint("⚠️ ไม่สามารถดึง device_id ได้: $e");
      return "unknown_device";
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
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 70,
                color: Color(0xFF1976D2),
              ),
              const SizedBox(height: 20),
              Text(
                "เข้าสู่ระบบ",
                style: GoogleFonts.kanit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 40),

              _buildTextField(
                _studentidController,
                "รหัสนิสิต",
                "กรอกรหัสนิสิตของคุณ",
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _passwordController,
                "รหัสผ่าน",
                "กรอกรหัสผ่าน",
                isPassword: true,
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    "เข้าสู่ระบบ",
                    style: GoogleFonts.kanit(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/register'),
                child: Text(
                  "ยังไม่มีบัญชี? สมัครสมาชิก",
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
