import 'package:flutter_app/app/models/api_return_value.dart';
import 'package:flutter_app/app/models/pengaduan.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../models/total_pengaduan.dart';
import '../models/user.dart';
import '../networking/report_api_service.dart';
class DashboardController extends GetxController {
  ReportApiService _reportApiService = ReportApiService();
  Rx<User?> user = Rx<User>(User());
  Rx<List<Pengaduan?>> pengaduanPending = Rx<List<Pengaduan?>>([]);
  Rx<TotalPengaduan> totalPengaduan = Rx<TotalPengaduan>(TotalPengaduan());


  Future<void> getUser()async
  {
    user.value = await Auth.user<User>();
  }

  Future<void> getTotalPengaduan() async
  {
    ApiReturnValue? result = await _reportApiService.fetchTotal();
    if(result != null)
    {
      if(result.status)
      {
        totalPengaduan.value = result.data as TotalPengaduan;
      }
    }
  }

  Future<void> getPengaduanPending()async
  {
    ApiReturnValue? result = await _reportApiService.fetchData('pending');
    if(result != null)
    {
      if(result.status)
      {
        pengaduanPending.update((val) {
          pengaduanPending.value = result.data as List<Pengaduan?>;
        });
      }
    }
  }

} 
