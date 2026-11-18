import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/menu/home.dart';
import 'package:tes/menu/profile.dart';
import 'package:tes/Pages/feat_page.dart';

class MainMenuController extends GetxController {
  final RxInt selectedIndex = 0.obs;


  void changePage(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> listPages = [HomePage(), FeatPage(), ProfilePage()];

}
