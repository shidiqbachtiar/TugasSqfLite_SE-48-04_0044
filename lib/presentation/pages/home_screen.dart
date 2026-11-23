import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:materisqflite/presentation/controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Text('LIST BARANG'),
          Expanded(
            child: Obx(() {
              final barangList = ctr.barangList;
              if (barangList.isEmpty) {
                return const Center(child: Text('Data Belum Ada'));
              }

              return ListView.builder(
                itemCount: barangList.length,
                itemBuilder: (context, index) {
                  final barang = barangList[index];
                  return Card(
                    child: ListTile(
                      title: Text(barang.nama),
                      subtitle: Text('Stok Barang ${barang.stok}'),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
