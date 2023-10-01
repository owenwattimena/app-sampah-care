import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_app/app/models/pengaduan.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/api_return_value.dart';
import '../networking/report_api_service.dart';

class AddReportController extends GetxController {
  ReportApiService _reportApiService = ReportApiService();
  Rx<File?> imagePick = Rx<File?>(null);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      imagePick.value = File(image.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<ApiReturnValue?> sendReport(Pengaduan pengaduan) async{
    return await _reportApiService.sendReport(pengaduan);
  }
}
