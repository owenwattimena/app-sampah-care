import 'package:nylo_framework/nylo_framework.dart';

/// Tanggapan Model.

class Tanggapan extends Model {
  final int? id;
  final String? isi, foto;
  Tanggapan({this.id, this.isi, this.foto});
  
  factory Tanggapan.fromJson(Map<String, dynamic> json) => Tanggapan(
    id: json['id'],
    isi: json['isi'],
    foto: json['foto'],
  );

  toJson() {

  }
}
