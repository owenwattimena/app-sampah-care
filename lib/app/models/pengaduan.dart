import 'package:nylo_framework/nylo_framework.dart';

/// Pengaduan Model.

class Pengaduan extends Model {
  final int? id;
  final String? isi, foto;
  final double? latitude, longitude;
  final String? status;
  final String? tanggal;
  Pengaduan({this.id, this.isi, this.foto, this.latitude, this.longitude, this.status, this.tanggal});
  
  factory Pengaduan.fromJson(Map<String, dynamic> json) => Pengaduan(
    id: json['id'],
    isi: json['isi'],
    foto: json['foto'],
    latitude: double.tryParse(json['latitude']),
    longitude: double.tryParse(json['longitude']),
    status: json['status'],
    tanggal: json['created_at']
  );
  List<Pengaduan?> toPengaduanList(List<dynamic> json) {
    return json.map((e) => e != null ? Pengaduan.fromJson(e as Map<String, dynamic>) : null).toList();
  }

  Map<String, dynamic> toJson() => {
    'id' : this.id,
    'isi' : this.isi,
    'foto' : this.foto,
    'latitude' : this.latitude,
    'longitude' : this.longitude,
    'status' : this.status,
    'created_at' : this.tanggal,
  };
  Future<Map<String, dynamic>> toJsonPost() async => {
    'id' : this.id,
    'isi' : this.isi,
    'foto' : await MultipartFile.fromFile(this.foto!, filename: this.foto!.split('/').last),
    'latitude' : this.latitude,
    'longitude' : this.longitude,
    'status' : this.status,
    'created_at' : this.tanggal,
  };
}
