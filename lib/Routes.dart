import 'package:get/get.dart';
import 'package:tes/Pages/feat_page.dart';
import 'package:tes/Pages/login_clone_fix.dart';
import 'package:tes/Pages/main_menu_pages.dart';
import 'package:tes/Pages/transaksi_page.dart';

class Routes {
  static const String Login = "/Login";
  static const String mainmenupage = "/mainmenupage";
  static const String transaksi = "/transaksi";
  static const String feat = "/feat";

  // Route login, main menu, transaksi, dan feat dipakai alur aplikasi.
  static final myPages = [
    GetPage(name: Login, page: () => LoginCloneFix()),
    GetPage(name: mainmenupage, page: () => MainMenuPages()),
    GetPage(name: transaksi, page: () => TransaksiPage()),
    GetPage(name: feat, page: () => FeatPage()),
  ];
}
