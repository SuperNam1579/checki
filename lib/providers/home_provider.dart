import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:convert';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool checkedIn = false;
  String? checkInTime;
  String? userName;
  String? userId; // ✅ เพิ่มตัวนี้เข้ามา
  String? token;  // ถ้ามีระบบ auth ก็เก็บ token ไว้ได้เลย

  Future<void> fetchHomeData() async {
    if (userId == null) {
      debugPrint("⚠️ userId เป็น null ไม่สามารถดึงข้อมูลได้");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getHomeData(userId: userId!);
      final data = jsonDecode(response.body);
      print("data: $data");

      if (response.statusCode == 200) {
        userName = data['data']['name'] ?? 'ผู้ใช้';
        checkedIn = data['checkedIn'] ?? false;
        checkInTime = data['checkInTime'];
      } else {
        debugPrint("⚠️ ดึงข้อมูลไม่สำเร็จ: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("เกิดข้อผิดพลาด: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> checkIn() async {
    try {
      final response = await ApiService.checkIn();
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        checkedIn = true;
        checkInTime = data['time'] ?? '';
      } else {
        debugPrint("⚠️ เช็คชื่อไม่สำเร็จ: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("เกิดข้อผิดพลาดตอนเช็คชื่อ: $e");
    }
    notifyListeners();
  }
}
