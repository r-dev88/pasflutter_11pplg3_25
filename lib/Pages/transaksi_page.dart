import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:tes/Controller/transaksi_ctrl.dart';
import 'package:tes/models/makanan_model.dart';

class TransaksiPage extends StatelessWidget {
  TransaksiPage({super.key});

  final controller = Get.put(
    TransaksiController(Get.arguments as MakananModel),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text("Transaksi Pembelian"),
        backgroundColor: const Color(0xFFEDEDED),
        foregroundColor: const Color(0xFF191919),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    controller.makanan.gambar,
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                      height: 190,
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.makanan.namaMakanan,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          controller.makanan.hargaRupiah,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF07C160),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.makanan.deskripsi,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Jumlah Makanan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _bulatTombol(Icons.remove, controller.kurangi),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: Obx(
                    () => TextField(
                      controller: controller.txtJumlah,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 6,
                      onChanged: controller.ubahJumlah,
                      onTap: () => controller.txtJumlah.selection =
                          TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.txtJumlah.text.length,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Jumlah',
                        counterText: '',
                        errorText: controller.pesanJumlah.value.isEmpty
                            ? null
                            : controller.pesanJumlah.value,
                        errorMaxLines: 2,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _bulatTombol(Icons.add, controller.tambah),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(
                  () => Column(
                    children: [
                      _barisRincian("Subtotal", controller.subtotalRupiah),
                      const SizedBox(height: 8),
                      _barisRincian("PPN (5%)", controller.ppnRupiah),
                      const Divider(height: 24),
                      _barisRincian(
                        "Total Bayar",
                        controller.totalRupiah,
                        tebal: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
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
                onPressed: () => _konfirmasiBayar(context),
                child: const Text(
                  "Bayar",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bulatTombol(IconData ikon, VoidCallback aksi) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF191919),
          elevation: 0,
          shape: const CircleBorder(),
        ),
        onPressed: aksi,
        child: Icon(ikon, size: 18,
            semanticLabel: ikon == Icons.add ? 'Tambah jumlah' : 'Kurangi jumlah'),
      ),
    );
  }

  Widget _barisRincian(String label, String nilai, {bool tebal = false}) {
    final gaya = TextStyle(
      fontSize: tebal ? 17 : 14,
      fontWeight: tebal ? FontWeight.bold : FontWeight.w500,
      color: tebal ? const Color(0xFF07C160) : const Color(0xFF191919),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: gaya), Text(nilai, style: gaya)],
    );
  }

  Future<void> _konfirmasiBayar(BuildContext context) async {
    controller.ubahJumlah(controller.txtJumlah.text);
    if (controller.jumlah.value == 0) return;
    final total = controller.totalRupiah;
    final jumlah = controller.jumlah.value;
    final nama = controller.makanan.namaMakanan;

    final setuju = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rincian Pembayaran"),
        content: Text(
          "$jumlah x $nama\n\n"
          "Subtotal: ${controller.subtotalRupiah}\n"
          "PPN (5%): ${controller.ppnRupiah}\n"
          "Total Bayar: $total\n\n"
          "Silahkan lakukan pembayaran",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Selesai"),
          ),
        ],
      ),
    );

    if (setuju != true || !context.mounted) return;
    Navigator.pop(context);
  }
}
