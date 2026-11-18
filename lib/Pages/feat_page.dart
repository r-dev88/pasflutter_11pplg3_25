import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes/Controller/api_config.dart';
import 'package:tes/Controller/feat_ctrl.dart';

class FeatPage extends StatelessWidget {
  FeatPage({super.key});

  final controller = Get.put(FeatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        title: const Text("Klub Premier League"),
        backgroundColor: const Color(0xFFEDEDED),
        foregroundColor: const Color(0xFF191919),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pesanError.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.pesanError.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: controller.ambilData,
                    child: const Text("Coba Lagi"),
                  ),
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.ambilData,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            itemCount: controller.daftarTim.length,
            itemBuilder: (context, index) {
              final tim = controller.daftarTim[index];
              return Card(
                color: Colors.white,
                elevation: 1,
                shadowColor: Colors.black12,
                margin: const EdgeInsets.only(bottom: 10),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  leading: SizedBox(
                    width: 48,
                    height: 48,
                    child: Image.network(
                      ApiConfig.badge(tim.strBadge),
                      semanticLabel: 'Logo ${tim.strTeam}',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.shield_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  title: Text(
                    tim.strTeam,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(tim.strStadium),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
