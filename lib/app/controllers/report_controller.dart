import 'package:get/get.dart';

import '../models/api_return_value.dart';
import '../models/pengaduan.dart';
import '../networking/report_api_service.dart';

class ReportController extends GetxController {
  ReportApiService _reportApiService = ReportApiService();
  Rx<List<Pengaduan?>> pengaduan = Rx<List<Pengaduan?>>([]);
    
  Future<void> getPengaduan(String status)async
  {
    ApiReturnValue? result = await _reportApiService.fetchData(status);
    if(result != null)
    {
      if(result.status)
      {
        pengaduan.update((val) {
          pengaduan.value = result.data as List<Pengaduan?>;
        });
      }
    }
  }

} 
