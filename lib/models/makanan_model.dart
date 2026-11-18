class MakananModel {
  final String namaMakanan;
  final int harga;
  final String deskripsi;
  final String gambar;

  const MakananModel({
    required this.namaMakanan,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
  });

  String get hargaRupiah => formatRupiah(harga);

  static String formatRupiah(int nilai) {
    final digit = nilai.toString();
    final buffer = StringBuffer('Rp');
    for (var i = 0; i < digit.length; i++) {
      if (i > 0 && (digit.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digit[i]);
    }
    return buffer.toString();
  }
}
