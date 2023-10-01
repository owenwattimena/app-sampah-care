

import 'package:flutter_app/app/models/api_return_value.dart';
import 'package:flutter_app/app/networking/report_api_service.dart';
import 'package:get/get.dart';

import '../models/tanggapan.dart';

class ReportDetailController extends GetxController {
  ReportApiService _reportApiService = ReportApiService();
  Rx<Tanggapan?> tanggapan = Rx<Tanggapan?>(Tanggapan());
  
  Future<void> getTanggapan(int id) async
  {
    ApiReturnValue? result = await _reportApiService.fetchFeedbackData(id);
    if(result != null)
    {
      if(result.status)
      {
        tanggapan.value = result.data as Tanggapan;
      }
    }

  }
} 
