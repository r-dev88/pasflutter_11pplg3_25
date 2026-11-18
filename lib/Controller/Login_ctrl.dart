import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/Routes.dart';
import 'package:http/http.dart' as http;
import 'package:tes/Controller/api_config.dart';
import 'package:tes/models/login_model.dart';

class LoginController extends GetxController {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();

  var isLoading = false.obs;

  final loginModel = Rxn<LoginModel>();

  Future<void> login() async {
    if (isLoading.value) return;
    if (txtUsername.text.trim().isEmpty || txtPassword.text.isEmpty) {
      _dialogGagal("Username dan kata sandi harus diisi.");
      return;
    }

    try {
      isLoading.value = true; 
      final url = ApiConfig.login;

      final response = await http.post(
        url,
        body: {
          "username": txtUsername.text.trim(),
          "password": txtPassword.text,
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        loginModel.value = loginModelFromJson(response.body);
        if (loginModel.value!.status == true) {
          Get.offAllNamed(Routes.mainmenupage);
        } else {
          _dialogGagal(loginModel.value!.message);
        }
      } else {
        _dialogGagal("Server login mengembalikan HTTP ${response.statusCode}.");
      }
    } catch (_) {
      _dialogGagal("Tidak dapat menghubungi server. Periksa koneksi. "
          "Untuk Chrome, jalankan run_web.bat agar API dapat diakses.");
    } finally {
      isLoading.value = false;
    }
  }

  void _dialogGagal(String pesan) {
    Get.dialog(
      AlertDialog(
        title: const Text("Login Gagal"),
        content: Text(pesan),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.onClose();
  }
}
