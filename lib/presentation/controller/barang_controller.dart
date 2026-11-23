import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:materisqflite/data/repo/barang_repo.dart';
import 'package:materisqflite/model/barang.dart';

class BarangController extends GetxController {
  BarangController(this.repo);

  final BarangRepo repo;
  final barangList = <Barang>[].obs;

  @override
  void onReady() {
    super.onReady();
    getBarang();
  }

  Future<void> getBarang() => _muatBarang(tampilkanSukses: true);

  Future<void> _muatBarang({required bool tampilkanSukses}) async {
    try {
      barangList.value = await repo.getAllBarang();
    } catch (_) {
      Get.snackbar('Error', 'Gagal', backgroundColor: Colors.red);
      return;
    }

    if (tampilkanSukses) {
      Get.snackbar('Sukses', 'Berhasil');
    }
  }

  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
    } catch (_) {
      Get.snackbar('Error', 'Gagal', backgroundColor: Colors.red);
      return;
    }

    Get.snackbar(
      'Sukses',
      'Barang dengan nama ${barang.nama} Berhasil ditambahkan',
    );
    await _muatBarang(tampilkanSukses: false);
  }

  Future<void> ubahBarang(Barang barang) async {
    try {
      if (await repo.update(barang) == 0) {
        Get.snackbar(
          'Error',
          'Barang tidak ditemukan',
          backgroundColor: Colors.red,
        );
      } else {
        Get.snackbar('Sukses', 'Barang berhasil diubah');
      }
    } catch (_) {
      Get.snackbar('Error', 'Gagal', backgroundColor: Colors.red);
      return;
    }

    await _muatBarang(tampilkanSukses: false);
  }

  Future<void> hapusBarang(int id) async {
    try {
      if (await repo.delete(id) == 0) {
        Get.snackbar(
          'Error',
          'Barang tidak ditemukan',
          backgroundColor: Colors.red,
        );
      } else {
        Get.snackbar('Sukses', 'Barang berhasil dihapus');
      }
    } catch (_) {
      Get.snackbar('Error', 'Gagal', backgroundColor: Colors.red);
      return;
    }

    await _muatBarang(tampilkanSukses: false);
  }
}
