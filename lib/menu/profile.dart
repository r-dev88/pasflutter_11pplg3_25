import 'package:flutter/material.dart';
import 'package:tes/Routes.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF07C160), Color(0xFF06AD56)],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('lib/assets/profile.jpg'),
                    ),
                    const SizedBox(height: 6),
                    const SizedBox(height: 14),
                    const Text(
                      "M.Royyan A.",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "11 PPLG 3 • No. Absen 25",
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Tester",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _tile(Icons.badge_outlined, "Nama Lengkap", "M.Royyan A."),
                  _tile(Icons.school_outlined, "Kelas / No. Absen", "11 PPLG 3 / 25"),
                  _tile(
                    Icons.email_outlined,
                    "Email",
                    "royganz1877@gmail.com",
                    showDivider: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                onTap: () => Get.offAllNamed(Routes.Login),
                leading: const Icon(Icons.logout, color: Color(0xFFE5484D)),
                title: const Text(
                  "Keluar Akun",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE5484D),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Color(0xFFBFBFBF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String judul,
    String isi, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 20, color: const Color(0xFF07C160)),
          title: Text(
            judul,
            style: const TextStyle(fontSize: 12, color: Color(0xFF888888)),
          ),
          subtitle: Text(
            isi,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191919),
            ),
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}
