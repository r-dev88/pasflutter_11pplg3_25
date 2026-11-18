import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tes/models/team_model.dart';

class FeatController extends GetxController {
  static const _url =
      'https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php?l=English%20Premier%20League';

  var isLoading = true.obs;
  var pesanError = ''.obs;
  final List<Team> daftarTim = <Team>[].obs;

  @override
  void onInit() {
    super.onInit();
    ambilData();
  }

  Future<void> ambilData() async {
    try {
      isLoading.value = true;
      pesanError.value = '';

      final response = await http.get(Uri.parse(_url))
          .timeout(const Duration(seconds: 20));
      if (response.statusCode != 200) {
        pesanError.value = 'Gagal memuat data (HTTP ${response.statusCode}).';
        return;
      }

      final model = premierLeagueModelFromJson(response.body);
      daftarTim.assignAll(model.teams);
      if (daftarTim.isEmpty) pesanError.value = 'Data klub tidak ditemukan.';
    } catch (_) {
      pesanError.value = 'Tidak dapat memuat klub. Periksa koneksi lalu coba lagi.';
    } finally {
      isLoading.value = false;
    }
  }
}
