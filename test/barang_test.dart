import 'package:flutter_test/flutter_test.dart';
import 'package:materisqflite/model/barang.dart';

void main() {
  test('Barang dapat disalin dan dikonversi dari dan ke JSON', () {
    const barang = Barang(id: 5, nama: 'Buku', stok: 4);
    final salinan = Barang.fromJson(barang.toJson());

    expect(salinan, barang);
    expect(salinan.hashCode, barang.hashCode);
    expect(barang.toString(), 'Barang(id: 5, nama: Buku, stok: 4)');

    final tanpaStok = barang.copyWith(stok: 0);
    expect(tanpaStok, const Barang(id: 5, nama: 'Buku', stok: 0));
    expect(tanpaStok, isNot(equals(barang)));

    const barangBaru = Barang(nama: 'Pensil', stok: 2);
    expect(Barang.fromJson(barangBaru.toJson()), barangBaru);
  });
}
