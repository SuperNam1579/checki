import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔗 URL หลักของ Backend (แก้ให้เป็นของเพื่อนคุณ)
  static const String baseUrl = 'https://checkin-backend.vercel.app/api';

  // 🟢 ฟังก์ชัน Login
  static Future<http.Response> login(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  // 🟣 ฟังก์ชัน Register
  static Future<http.Response> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }
}
