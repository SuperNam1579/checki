import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("user_id");

      if (userId != null) {
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        homeProvider.userId = userId;
        homeProvider.fetchHomeData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'หน้าหลัก',
      //     style: GoogleFonts.kanit(fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: const Color(0xFF1976D2),
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: homeProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1976D2)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HEADER =================
                  Text(
                    "สวัสดี, ${homeProvider.userName ?? '...'} 👋",
                    style: GoogleFonts.kanit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEEE ที่ d MMMM yyyy', 'th_TH')
                        .format(DateTime.now()),
                    style: GoogleFonts.kanit(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ================= ปุ่มเช็คชื่อ =================
                  Center(
                    child: GestureDetector(
                      onTap: homeProvider.checkedIn
                          ? null
                          : () => _handleCheckIn(context, homeProvider),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: homeProvider.checkedIn
                              ? const LinearGradient(
                                  colors: [Colors.blueGrey, Colors.white70],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : const LinearGradient(
                                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            homeProvider.checkedIn ? "เช็คชื่อแล้ว" : "เช็คชื่อ",
                            style: GoogleFonts.kanit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ================= ประวัติการเช็คชื่อ =================
                  Text(
                    "กิจกรรมล่าสุด",
                    style: GoogleFonts.kanit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1976D2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFBBDEFB)),
                    ),
                    child: Text(
                      homeProvider.checkedIn
                          ? "คุณเช็คชื่อเวลา ${homeProvider.checkInTime ?? '-'}"
                          : "ยังไม่มีประวัติการเช็คชื่อ",
                      style: GoogleFonts.kanit(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// ✅ Popup + เรียก Provider เช็คชื่อ
  void _handleCheckIn(BuildContext context, HomeProvider homeProvider) async {
    await homeProvider.checkIn();

    if (context.mounted) {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
              Text(
                'เวลา $formattedTime',
                style: GoogleFonts.kanit(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
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
  }
}
