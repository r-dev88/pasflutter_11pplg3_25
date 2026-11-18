import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/Components/Custom_TextFIelds.dart';
import 'package:tes/Controller/Login_ctrl.dart';

class LoginCloneFix extends StatelessWidget {
  LoginCloneFix({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Apps PAS",
          style: TextStyle(
            color: Color(0xFF07C160),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Logo WeChat: kotak hijau dengan dua balon chat
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  color: const Color(0xFF07C160),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF07C160).withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(child: _WeChatLogo()),
              ),

              const SizedBox(height: 20),
              const Text(
                "WeChat",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF07C160),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Silahkan login",
                style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
              ),

              const SizedBox(height: 32),

              // Input Username / Email / Nomor HP
              CustomTextfield(
                hint: "Masukkan Username",
                txtController: controller.txtUsername,
                cornerRadius: 12,
              ),
              const SizedBox(height: 12),

              CustomTextfield(
                hint: "Masukkan Password",
                txtController: controller.txtPassword,
                cornerRadius: 12,
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 28),

              Obx(
                () => controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF07C160),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF07C160),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            controller.login();
                          },
                          child: const Text(
                            "Masuk",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Lupa kata sandi?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF07C160),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Logo sederhana ala WeChat: dua balon chat putih dengan dua mata
class _WeChatLogo extends StatelessWidget {
  const _WeChatLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 50,
      child: Stack(
        children: [
          // Balon chat besar
          Positioned(
            left: 0,
            top: 0,
            child: _bubble(
              size: 38,
              bubbleColor: Colors.white,
              eyeColor: const Color(0xFF07C160),
            ),
          ),
          // Balon chat kecil
          Positioned(
            right: 0,
            bottom: 0,
            child: _bubble(
              size: 28,
              bubbleColor: const Color(0xFFF7F7F7),
              eyeColor: const Color(0xFF07C160),
            ),
          ),
        ],
      ),
    );
  }

  // Balon chat: ikon bubble + dua mata
  Widget _bubble({
    required double size,
    required Color bubbleColor,
    required Color eyeColor,
  }) {
    final eye = size * 0.13;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Icon(Icons.chat_bubble, color: bubbleColor, size: size),
          Positioned(
            top: size * 0.36,
            left: size * 0.30,
            child: Container(
              width: eye,
              height: eye,
              decoration: BoxDecoration(color: eyeColor, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: size * 0.36,
            left: size * 0.56,
            child: Container(
              width: eye,
              height: eye,
              decoration: BoxDecoration(color: eyeColor, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
