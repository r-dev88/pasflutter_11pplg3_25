import 'package:get/get.dart';
import 'package:tes/models/makanan_model.dart';

class HomeController extends GetxController {
  final List<MakananModel> daftarMakanan = const [
    MakananModel(
      namaMakanan: 'Nasi Goreng Spesial',
      harga: 25000,
      deskripsi:
          'Nasgor wenak.',
      gambar: 'lib/assets/makanan_nasi_goreng.jpg',
    ),
    MakananModel(
      namaMakanan: 'Ayam Bakar Madu',
      harga: 30000,
      deskripsi:
          'Ayam Bakar Oles Madu',
      gambar: 'lib/assets/makanan_ayam_bakar.jpg',
    ),
    MakananModel(
      namaMakanan: 'Sate Ayam Madura',
      harga: 28000,
      deskripsi:
          '10 Tusuk Sate',
      gambar: 'lib/assets/makanan_sate_ayam.jpg',
    ),
    MakananModel(
      namaMakanan: 'Mie Ayam Bakso',
      harga: 20000,
      deskripsi:
          'Mie ayam bakso cak ferry',
      gambar: 'lib/assets/makanan_mie_ayam.jpg',
    ),
    MakananModel(
      namaMakanan: 'Es Teh Manis Jumbo',
      harga: 8000,
      deskripsi: 'Es Teh Jumbo',
      gambar: 'lib/assets/makanan_es_teh.jpg',
    ),
  ];
}
