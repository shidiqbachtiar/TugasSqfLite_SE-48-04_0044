import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:materisqflite/data/repo/barang_repo.dart';
import 'package:materisqflite/main.dart';
import 'package:materisqflite/model/barang.dart';
import 'package:materisqflite/presentation/controller/barang_controller.dart';

void main() {
  tearDown(() => Get.reset());

  testWidgets('Daftar menampilkan barang yang baru disimpan', (tester) async {
    Get.put<BarangRepo>(_RepoMemori());
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Data Belum Ada'), findsOneWidget);
    expect(find.text('Berhasil'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    final controller = Get.find<BarangController>();
    await controller.tambahBarang(const Barang(nama: 'Buku', stok: 4));
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
    expect(find.text('Berhasil'), findsNothing);
  });
}

class _RepoMemori implements BarangRepo {
  final _barang = <Barang>[];

  @override
  Future<int> insert(Barang barang) async {
    _barang.add(barang);
    return _barang.length;
  }

  @override
  Future<List<Barang>> getAllBarang() async => List.of(_barang);
}
