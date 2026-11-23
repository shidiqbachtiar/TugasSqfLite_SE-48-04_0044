import 'package:materisqflite/data/dao/barang_dao.dart';
import 'package:materisqflite/model/barang.dart';

abstract class BarangRepo {
  Future<int> insert(Barang barang);
  Future<List<Barang>> getAllBarang();
}

class BarangRepoImpl implements BarangRepo {
  const BarangRepoImpl(this.dao);

  final BarangDao dao;

  @override
  Future<int> insert(Barang barang) => dao.insert(barang);

  @override
  Future<List<Barang>> getAllBarang() => dao.getAllBarang();
}
