import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;

  /// ✅ ดึง device_id ตาม platform
  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? androidInfo.device ?? "unknown_android";
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? "unknown_ios";
      } else {
        return "unknown_device";
      }
    } catch (e) {
      debugPrint("⚠️ ไม่สามารถดึง device id ได้: $e");
      return "unknown_device";
    }
  }

  /// 🟢 ฟังก์ชัน Login
  Future<bool> login(String studentId, String password) async {
    try {
      final deviceId = await _getDeviceId();
      final response = await ApiService.login({
        'device_id': deviceId,
        'student_id': studentId,
        'password': password,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user = UserModel.fromJson(data['user']);
        notifyListeners();
        return true;
      } else {
        debugPrint('❌ Login failed: ${data['message']}');
        return false;
      }
    } catch (e) {
      debugPrint('⚠️ Error during login: $e');
      return false;
    }
  }

  /// 🟦 ฟังก์ชัน Register พร้อม device_id จริง
  Future<bool> register({
    required String name,
    required String studentId,
    required String email,
    required String password,
    required String rePassword,
  }) async {
    try {
      final deviceId = await _getDeviceId(); // ✅ ได้ค่า device id จากเครื่อง

      final response = await ApiService.register({
        'name': name,
        'student_id': studentId,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'device_id': deviceId,
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
}
