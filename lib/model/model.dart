const String table = 'latihan';

class Fields {
  static const List<String> values = [id, nama, alamat];

  static const String id = '_id';
  static const String nama = 'nama';
  static const String alamat = 'alamat';
}

class Data {
  final String nama;
  final String alamat;

  const Data({required this.nama, required this.alamat});

  static Data fromJson(Map<String, Object?> json) => Data(
      nama: json[Fields.nama] as String, alamat: json[Fields.alamat] as String);

  Map<String, Object?> toJson() => {Fields.nama: nama, Fields.alamat: alamat};
}
