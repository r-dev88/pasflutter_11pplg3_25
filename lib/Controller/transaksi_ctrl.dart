import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/models/makanan_model.dart';

class TransaksiController extends GetxController {
  TransaksiController(this.makanan);

  final MakananModel makanan;
  final txtJumlah = TextEditingController(text: '1');
  final jumlah = 1.obs;
  final pesanJumlah = ''.obs;

  @override
  void onClose() {
    txtJumlah.dispose();
    super.onClose();
  }

  void ubahJumlah(String value) {
    final angka = int.tryParse(value);
    final valid = angka != null && angka > 0 && angka <= 999999;
    jumlah.value = valid ? angka : 0;
    pesanJumlah.value = valid ? '' : 'Masukkan jumlah 1–999999.';
  }

  void tambah() {
    if (jumlah.value >= 999999) return;
    txtJumlah.text = '${jumlah.value + 1}';
    ubahJumlah(txtJumlah.text);
  }

  void kurangi() {
    if (jumlah.value <= 1) return;
    txtJumlah.text = '${jumlah.value - 1}';
    ubahJumlah(txtJumlah.text);
  }

  int get subtotal => makanan.harga * jumlah.value;

  int get ppn => (subtotal * 0.05).round();

  int get totalBayar => subtotal + ppn;

  String get subtotalRupiah => MakananModel.formatRupiah(subtotal);

  String get ppnRupiah => MakananModel.formatRupiah(ppn);

  String get totalRupiah => MakananModel.formatRupiah(totalBayar);
}
