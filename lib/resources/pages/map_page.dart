import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/maps_controller.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends NyStatefulWidget {
  static const path = '/map';
  final Controller controller = Controller();

  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends NyState<MapPage> {
  final MapsController controller = MapsController();
  final mapController = MapController();
  // List<Widget> layers = [
  //   TileLayer(
  //     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //     userAgentPackageName: 'com.wentox.sampah_care',
  //   ),
  //   MarkerLayer(
  //     markers: [
  //       Marker(
  //         point: LatLng(
  //             controller.currentPosition.value!.latitude,
  //             controller.currentPosition.value!.longitude),
  //         width: 70,
  //         height: 70,
  //         builder: (context) => Image.asset(
  //             'public/assets/app_icon/sampah_icon.png'),
  //       ),
  //     ],
  //   ),
  // ];
  // String? _currentAddress;
  @override
  init() async {
    super.init();
    controller.layers.value.add(TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.wentox.sampah_care',
    ));
    if (widget.data() == null) {
      _getCurrentPosition();
    } else {
      Position data = widget.data();
      controller.currentPosition.value = data;
      controller.layers.value.add(MarkerLayer(
        markers: [
          Marker(
            point: LatLng(data.latitude, data.longitude),
            width: 70,
            height: 70,
            builder: (context) =>
                Image.asset('public/assets/app_icon/sampah_icon.png'),
          ),
        ],
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print(position.latitude);
      print(position.longitude);
      controller.currentPosition.value = position;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            Obx(() {
              if (controller.currentPosition.value?.latitude != null) {
                if (controller.layers.value.length <= 1) {
                  controller.layers.value.add(
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                              controller.currentPosition.value!.latitude,
                              controller.currentPosition.value!.longitude),
                          width: 70,
                          height: 70,
                          builder: (context) => Image.asset(
                              'public/assets/app_icon/sampah_icon.png'),
                        ),
                      ],
                    ),
                  );
                }
                return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      onTap: (widget.data() != null) ? null : (tapPosition, point) {
                        print("${point.latitude}");
                        print("${point.longitude}");
                        controller.layers.update((val) {
                          controller.layers.value.removeLast();
                          controller.layers.value.add(MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(point.latitude, point.longitude),
                                width: 70,
                                height: 70,
                                builder: (context) => Image.asset(
                                    'public/assets/app_icon/sampah_icon.png'),
                              ),
                            ],
                          ));
                        });
                        controller.currentPosition.value = Position(
                            longitude: point.longitude,
                            latitude: point.latitude,
                            timestamp: null,
                            accuracy: 0,
                            altitude: 0,
                            heading: 0,
                            speed: 0,
                            speedAccuracy: 0);
                      },
                      center: LatLng(
                          controller.currentPosition.value?.latitude ??
                              51.509364,
                          controller.currentPosition.value?.longitude ??
                              -0.128928),
                      zoom: 18,
                      maxZoom: 18),
                  nonRotatedChildren: [
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                  children: controller.layers.value,
                );
              }
              return SizedBox();
            }),
            (widget.data() == null) ? Positioned(
              bottom: 30,
              left: 30,
              child: ElevatedButton(
                onPressed: () {
                  this.pop(result: controller.currentPosition.value);
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width - 60, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      ThemeColor.get(context).primaryContent),
                ),
                child: Text('PILIH'),
              ),
            ) : SizedBox(),
          ],
        )),
      ),
    );
  }
}
