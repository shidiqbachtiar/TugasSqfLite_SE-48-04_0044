import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:materisqflite/model/barang.dart';
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Edit barang',
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              final hasil = await _formBarang(context, barang);
                              if (hasil != null) await ctr.ubahBarang(hasil);
                            },
                          ),
                          IconButton(
                            tooltip: 'Hapus barang',
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final hapus = await _konfirmasiHapus(
                                context,
                                barang,
                              );
                              if (hapus == true) {
                                await ctr.hapusBarang(barang.id!);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah barang',
        onPressed: () async {
          final hasil = await _formBarang(context);
          if (hasil != null) await ctr.tambahBarang(hasil);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Barang?> _formBarang(BuildContext context, [Barang? barang]) {
    final formKey = GlobalKey<FormState>();
    var nama = barang?.nama ?? '';
    var stok = barang?.stok.toString() ?? '';

    return showDialog<Barang>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(barang == null ? 'Tambah Barang' : 'Edit Barang'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: nama,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  onChanged: (value) => nama = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: stok,
                  decoration: const InputDecoration(labelText: 'Stok'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => stok = value,
                  validator: (value) {
                    final jumlah = int.tryParse(value?.trim() ?? '', radix: 10);
                    if (jumlah == null || jumlah < 0) {
                      return 'Stok harus bulat dan ≥ 0';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              Navigator.pop(
                context,
                Barang(
                  id: barang?.id,
                  nama: nama.trim(),
                  stok: int.parse(stok.trim(), radix: 10),
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _konfirmasiHapus(BuildContext context, Barang barang) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Hapus barang ${barang.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
