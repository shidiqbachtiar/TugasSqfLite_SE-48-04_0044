import 'package:get/get.dart';
import 'package:materisqflite/data/dao/barang_dao.dart';
import 'package:materisqflite/data/database/db_helper.dart';
import 'package:materisqflite/data/repo/barang_repo.dart';
import 'package:materisqflite/presentation/controller/barang_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final dbHelper = Get.put(DbHelper());
    final dao = Get.put(BarangDao(dbHelper));
    final repo = Get.put<BarangRepo>(BarangRepoImpl(dao));
    Get.put(BarangController(repo));
  }
}
