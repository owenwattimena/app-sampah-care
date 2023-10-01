import 'package:nylo_framework/nylo_framework.dart';

class User extends Model {
  int? id;
  String? nik;
  String? nama;
  String? username;
  String? password;
  String? token;

  User(
      {this.id, this.nik, this.nama, this.username, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json, {String? token}) => User(
        id: json['id'],
        nik: json['nik'],
        nama: json['nama'],
        username: json['username'],
        password: json['password']??null,
        token: token,
      );

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "nik": this.nik,
        "nama": this.nama,
        "username": this.username,
        "password": this.password,
        "token": this.token
      };
  toRegisterJson() => {
        "nik": this.nik,
        "nama": this.nama,
        "username": this.username,
        "password": this.password
      };
  toLoginJson() => {
        "username": this.username,
        "password": this.password
      };
  @override
  String toString() {
    return "NIK : ${this.nik}, NAMA : ${this.nama}, USERNAME : ${this.username}, TOKEN : ${this.token}";
  }
}
