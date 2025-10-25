import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔗 URL หลักของ Backend
  static const String baseUrl = 'https://6qdt0zs2-80.asse.devtunnels.ms/api';

  // 🟢 ฟังก์ชัน Login
  static Future<http.Response> login(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  // 🟣 ฟังก์ชัน Register
  static Future<http.Response> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  // 🔵 ฟังก์ชันดึงข้อมูลหน้า Home (หลัง Login)
  static Future<http.Response> getHomeData({
    required String userId, // ✅ เพิ่ม userId เข้ามาเป็น required
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl/devices/$userId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  // 🟡 ฟังก์ชัน Check-In (กดปุ่มเช็คชื่อ)
  static Future<http.Response> checkIn({String? token}) async {
    final url = Uri.parse('$baseUrl/home/checkin');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
