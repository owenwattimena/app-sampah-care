import '/app/models/tanggapan.dart';
import '/app/models/total_pengaduan.dart';
import '/app/networking/report_api_service.dart';
import '/app/models/pengaduan.dart';
import '/app/models/api_return_value.dart';
import '/app/networking/user_api_service.dart';
import 'package:flutter_app/app/models/user.dart';
import 'package:flutter_app/app/networking/dio/base_api_service.dart';
import '/app/networking/api_service.dart';

/*
|--------------------------------------------------------------------------
| Model Decoders
| -------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/5.x/decoders#model-decoders
|--------------------------------------------------------------------------
*/

final Map<Type, dynamic> modelDecoders = {
  List<User>: (data) => List.from(data).map((json) => User.fromJson(json)).toList(),
  //
  User: (data) => User.fromJson(data),

  // User: (data) => User.fromJson(data),

  List<ApiReturnValue>: (data) => List.from(data).map((json) => ApiReturnValue.fromJson(json)).toList(),

  ApiReturnValue: (data) => ApiReturnValue.fromJson(data),

  List<Pengaduan>: (data) => List.from(data).map((json) => Pengaduan.fromJson(json)).toList(),

  Pengaduan: (data) => Pengaduan.fromJson(data),

  List<TotalPengaduan>: (data) => List.from(data).map((json) => TotalPengaduan.fromJson(json)).toList(),

  TotalPengaduan: (data) => TotalPengaduan.fromJson(data),

  List<Tanggapan>: (data) => List.from(data).map((json) => Tanggapan.fromJson(json)).toList(),

  Tanggapan: (data) => Tanggapan.fromJson(data),
};

/*
|--------------------------------------------------------------------------
| API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/5.x/decoders#api-decoders
|--------------------------------------------------------------------------
*/

final Map<Type, BaseApiService> apiDecoders = {
  ApiService: ApiService(),

  // ...

  UserApiService: UserApiService(),

  ReportApiService: ReportApiService(),
};
  
  
