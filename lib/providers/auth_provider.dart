import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;

  Future<bool> login(String studentId, String password) async {
    try {
      final response = await ApiService.login({
        'student_id': studentId,
        'password': password,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = UserModel.fromJson(data['user']);
        notifyListeners();
        return true;
      } else {
        debugPrint('Login failed: ${data['message']}');
        return false;
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  // 🟢 วาง register() ตรงนี้เลย 🔽
  Future<bool> register({
    required String name,
    required String studentId,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    try {
      final response = await ApiService.register({
        'name': name,
        'student_id': studentId,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'device_id': 'flutter_app_001',
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        debugPrint("✅ สมัครสมาชิกสำเร็จ: ${data['message']}");
        return true;
      } else {
        debugPrint("❌ สมัครไม่สำเร็จ: ${data['message']}");
        return false;
      }
    } catch (e) {
      debugPrint("⚠️ Register Error: $e");
      return false;
    }
  }
} // 🔚 ปิดคลาสตรงนี้
