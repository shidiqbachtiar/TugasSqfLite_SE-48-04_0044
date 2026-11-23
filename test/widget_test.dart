import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:materisqflite/data/repo/barang_repo.dart';
import 'package:materisqflite/main.dart';
import 'package:materisqflite/model/barang.dart';

void main() {
  tearDown(() => Get.reset());

  testWidgets('Form memvalidasi input dan daftar mengikuti CRUD', (
    tester,
  ) async {
    Get.put<BarangRepo>(_RepoMemori());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Data Belum Ada'), findsOneWidget);
    expect(find.text('Berhasil'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Tambah barang'));
    await tester.pumpAndSettle();

    final nama = find.byType(TextFormField).at(0);
    final stok = find.byType(TextFormField).at(1);
    final simpan = find.text('Simpan');
    await tester.enterText(nama, '  ');
    await tester.enterText(stok, '-1');
    await tester.tap(simpan);
    await tester.pumpAndSettle();
    expect(find.text('Nama wajib diisi'), findsOneWidget);
    expect(find.text('Stok harus bulat dan ≥ 0'), findsOneWidget);

    await tester.enterText(nama, ' Buku ');
    await tester.enterText(stok, '4');
    await tester.tap(simpan);
    await tester.pumpAndSettle();

    expect(find.text('Data Belum Ada'), findsNothing);
    expect(find.text('Buku'), findsOneWidget);
    expect(find.text('Stok Barang 4'), findsOneWidget);
    expect(
      find.text('Barang dengan nama Buku Berhasil ditambahkan'),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Edit barang'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, 'Buku'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, '4'), findsOneWidget);
    await tester.enterText(nama, 'Pensil');
    await tester.enterText(stok, '0');
    await tester.tap(simpan);
    await tester.pumpAndSettle();
    expect(find.text('Buku'), findsNothing);
    expect(find.text('Pensil'), findsOneWidget);
    expect(find.text('Stok Barang 0'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Hapus barang'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Pensil'), findsOneWidget);

    await tester.tap(find.byTooltip('Hapus barang'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();
    expect(find.text('Pensil'), findsNothing);
    expect(find.text('Data Belum Ada'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}

class _RepoMemori implements BarangRepo {
  final _barang = <Barang>[];
  var _idTerakhir = 0;

  @override
  Future<int> insert(Barang barang) async {
    final id = ++_idTerakhir;
    _barang.insert(0, barang.copyWith(id: id));
    return id;
  }

  @override
  Future<List<Barang>> getAllBarang() async => List.of(_barang);

  @override
  Future<int> update(Barang barang) async {
    final index = _barang.indexWhere((item) => item.id == barang.id);
    if (index == -1) return 0;
    _barang[index] = barang;
    return 1;
  }

  @override
  Future<int> delete(int id) async {
    final index = _barang.indexWhere((item) => item.id == id);
    if (index == -1) return 0;
    _barang.removeAt(index);
    return 1;
  }
}
