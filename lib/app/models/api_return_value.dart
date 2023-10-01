import 'package:nylo_framework/nylo_framework.dart';

/// ApiReturnValue Model.

class ApiReturnValue<T> extends Model {
  int? code;
  String? message;
  bool status;
  T? data;
  ApiReturnValue({this.code = 400, this.status = false, this.message, this.data});
  
  factory ApiReturnValue.fromJson(Map<String, dynamic> json, {T? data}) => ApiReturnValue(
    code: json['meta']['code'],
    status: json['meta']['status'],
    message: json['meta']['message'],
    data: data
  );
  
  toJson() {

  }
}
