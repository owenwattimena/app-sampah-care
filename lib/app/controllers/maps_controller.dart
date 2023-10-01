import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class MapsController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  Rx<List<Widget>> layers = Rx<List<Widget>>([]);

} 
