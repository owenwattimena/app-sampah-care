import 'package:nylo_framework/nylo_framework.dart';

/// TotalPengaduan Model.

class TotalPengaduan extends Model {
  final int pending;
  final int proses;
  final int selesai;
  TotalPengaduan({this.pending = 0, this.proses = 0, this.selesai = 0});
  
  factory TotalPengaduan.fromJson(Map<String, dynamic> json) => TotalPengaduan(
    pending: json['pending'],
    proses: json['proses'],
    selesai: json['selesai']
  );

  toJson() {

  }
}
