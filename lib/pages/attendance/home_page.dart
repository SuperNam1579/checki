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

    // Popup แสดงผล
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], // ม่วง-น้ำเงิน
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "สวัสดี, น้ำ 👋",
              style: GoogleFonts.kanit(
                fontSize: 22,
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: checkedIn
                        ? const LinearGradient(
                            colors: [Colors.white24, Colors.white10],
                          )
                        : const LinearGradient(
                            colors: [Colors.white, Colors.white70],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: [
                      if (!checkedIn)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(2, 4),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      checkedIn ? "เช็คชื่อแล้ว" : "เช็คชื่อ",
                      style: GoogleFonts.kanit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: checkedIn ? Colors.purple[200] : Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // ประวัติ
            Text(
              "กิจกรรมล่าสุด",
              style: GoogleFonts.kanit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                checkedIn
                    ? "คุณเช็คชื่อเวลา $checkInTime"
                    : "ยังไม่มีประวัติการเช็คชื่อ",
                style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
