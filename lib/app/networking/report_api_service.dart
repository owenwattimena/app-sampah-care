import 'package:flutter/material.dart';
import '../models/total_pengaduan.dart';
import '../repositories/auth_repository.dart';
import '/app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../models/tanggapan.dart';
import '../models/api_return_value.dart';
import '../models/pengaduan.dart';

class ReportApiService extends BaseApiService {
  ReportApiService({BuildContext? buildContext}) : super(buildContext);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  /// Example API Request
  Future<ApiReturnValue?> fetchData(String status) async {
    String? token = await AuthRepository().token;
    return await network<ApiReturnValue>(
        request: (request) => request.get("/report?status=$status"),
        bearerToken: token,
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: Pengaduan().toPengaduanList(data['data']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
  /// Example API Request
  Future<ApiReturnValue?> fetchDetailData(int id) async {
    String? token = await AuthRepository().token;
    return await network<ApiReturnValue>(
        request: (request) => request.get("/report/$id"),
        bearerToken: token,
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: Pengaduan.fromJson(data['data']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
  /// Example API Request
  Future<ApiReturnValue?> fetchFeedbackData(int id) async {
    String? token = await AuthRepository().token;
    return await network<ApiReturnValue>(
        request: (request) => request.get("/report/$id/feedback"),
        bearerToken: token,
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: Tanggapan.fromJson(data['data']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
  /// Example API Request
  Future<ApiReturnValue?> fetchTotal() async {
    String? token = await AuthRepository().token;
    return await network<ApiReturnValue>(
        request: (request) => request.get("/report/total"),
        bearerToken: token,
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: TotalPengaduan.fromJson(data['data']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
  /// Example API Request
  Future<ApiReturnValue?> sendReport(Pengaduan pengaduan) async {
    String? token = await AuthRepository().token;
    FormData data = FormData.fromMap(await pengaduan.toJsonPost());
    return await network<ApiReturnValue>(
        request: (request) => request.post("/report", data: data),
        bearerToken: token,
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }


}
