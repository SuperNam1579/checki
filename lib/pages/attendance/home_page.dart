import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool checkedIn = false;
  String checkInTime = '';

  void _checkIn() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);

    // เด้ง popup
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
              'เช็คชื่อสำเร็จ!',
              style: GoogleFonts.kanit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 8),
            Text('เวลา $formattedTime', style: GoogleFonts.kanit(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  checkedIn = true;
                  checkInTime = formattedTime;
                });
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
            colors: [
              Color(0xFF6A11CB), // ม่วงเข้ม
              Color(0xFF2575FC), // ฟ้าน้ำทะเล
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ชื่อผู้ใช้
            Text(
              "สวัสดี, น้ำ",
              style: GoogleFonts.kanit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "วันศุกร์ที่ 24 ตุลาคม 2568",
              style: GoogleFonts.kanit(color: Colors.white70),
            ),
            const SizedBox(height: 40),

            // ปุ่มเช็คชื่อ
            Center(
              child: GestureDetector(
                onTap: checkedIn ? null : _checkIn,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: checkedIn ? Colors.white24 : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      checkedIn ? "เช็คชื่อแล้ว" : "เช็คชื่อ",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: checkedIn ? Colors.purple[200] : Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
            Text(
              "กิจกรรมล่าสุด",
              style: GoogleFonts.kanit(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              checkedIn
                  ? "คุณเช็คชื่อเวลา $checkInTime"
                  : "ยังไม่มีประวัติการเช็คชื่อ",
              style: GoogleFonts.kanit(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
