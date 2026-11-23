import 'dart:convert';

class Barang {
  const Barang({this.id, required this.nama, required this.stok});

  final int? id;
  final String nama;
  final int stok;

  Barang copyWith({int? id, String? nama, int? stok}) {
    return Barang(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
    );
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'] as int?,
      nama: map['nama'] as String,
      stok: map['stok'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'stok': stok};
  }

  factory Barang.fromJson(String source) {
    return Barang.fromMap(jsonDecode(source) as Map<String, dynamic>);
  }

  String toJson() => jsonEncode(toMap());

  @override
  String toString() => 'Barang(id: $id, nama: $nama, stok: $stok)';

  @override
  bool operator ==(Object other) {
    return other is Barang &&
        id == other.id &&
        nama == other.nama &&
        stok == other.stok;
  }

  @override
  int get hashCode => Object.hash(id, nama, stok);
}
