import 'package:flutter/material.dart';
import '../models/api_return_value.dart';
import '../models/user.dart';
import '/app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';


class UserApiService extends BaseApiService {
  UserApiService({BuildContext? buildContext}) : super(buildContext);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  /// Example API Request
  Future<ApiReturnValue?> register(User user) async {
    return await network<ApiReturnValue>(
        request: (request) => request.post("/register", data: user.toRegisterJson()),
        handleSuccess: (response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: data['data']);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
  /// Example API Request
  Future<ApiReturnValue?> login(User user) async {
    return await network<ApiReturnValue>(
        request: (request) => request.post("/login", data: user.toLoginJson()),
        handleSuccess: (response) {

          dynamic data = response.data;
          return ApiReturnValue.fromJson(data, data: User.fromJson(data['data']['user'], token: data['data']['token']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        }
    );
  }
}
