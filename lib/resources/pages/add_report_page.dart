import 'package:flutter/material.dart';
import 'package:flutter_app/app/models/api_return_value.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/pengaduan.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/add_report_controller.dart';
import 'package:get/get.dart';

import 'map_page.dart';

class AddReportPage extends NyStatefulWidget {
  static const path = '/add-report';

  AddReportPage({Key? key}) : super(key: key);

  @override
  _AddReportPageState createState() => _AddReportPageState();
}

class _AddReportPageState extends NyState<AddReportPage> {
  final AddReportController controller = AddReportController();
  TextEditingController isiController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();

  // ignore: unused_field
  Position? _position;
  Key _key = Key('form');

  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeColor.get(context).primaryContent,
        child: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                  color: ThemeColor.get(context).primaryContent,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,
                              color: ThemeColor.get(context).background)),
                      Text("Buat Pengaduan")
                          .titleMedium(context)
                          .fontWeightBold()
                          .setColor(context,
                              (color) => ThemeColor.get(context).background)
                    ],
                  )),
              Positioned(
                  top: 125,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ThemeColor.get(context).background,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Image.asset('public/assets/images/sampah.png'),
                          Obx(() => controller.imagePick.value != null
                              ? Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.file(
                                            controller.imagePick.value!,
                                            height: 200,
                                            fit: BoxFit.contain),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () {
                                              controller.imagePick.value = null;
                                            },
                                            icon: Icon(Icons.close)),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Pilih Foto'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await controller.pickImage(
                                                    ImageSource.gallery);
                                              },
                                              icon: Icon(Icons.photo)),
                                          IconButton(
                                              onPressed: () async {
                                                await controller.pickImage(
                                                    ImageSource.camera);
                                              },
                                              icon: Icon(Icons.camera)),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          Form(
                              key: _key,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: isiController,
                                    decoration: const InputDecoration(
                                        label: Text('Isi Pengaduan')),
                                    validator: (value) {
                                      if (value == null)
                                        return 'Isi Pengaduan tidak boleh kosong';
                                      return null;
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      routeTo(MapPage.path, onPop: (value) {
                                        if (value != null) {
                                          controller.latitude.value =
                                              value.latitude;
                                          controller.longitude.value =
                                              value.longitude;
                                          setState(() {
                                            lokasiController.text =
                                                "${value.latitude}, ${value.longitude}";
                                            _position = value;
                                          });
                                        }
                                      });
                                    },
                                    child: TextFormField(
                                      controller: lokasiController,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        hintText: "Pilih Lokasi",
                                        // label: Text('Lokasi'),
                                      ),
                                      validator: (value) {
                                        if (value == null)
                                          return 'Lokasi tidak boleh kosong';
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  ElevatedButton(
                                    onPressed: save,
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(Size(
                                          MediaQuery.of(context).size.width -
                                              60,
                                          45)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ThemeColor.get(context)
                                                  .primaryContent),
                                    ),
                                    child: Text('Buat Pengaduan'),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }

  void save() async {
    if (controller.imagePick.value == null) {
      showToastOops(description: "Foto tidak boleh kosong.");
      return;
    }
    setLoading(true, name: 'addReport');

    Pengaduan pengaduan = Pengaduan(
      foto: controller.imagePick.value!.path,
      isi: isiController.text,
      latitude: controller.latitude.value,
      longitude: controller.longitude.value,
    );
    ApiReturnValue? result = await controller.sendReport(pengaduan);
    if (result != null) {
      if (result.status) {
        showToastSuccess(description: result.message!);
        Navigator.pop(context);
      } else {
        showToastSorry(description: result.message!);
      }
    } else {
      showToastSorry(description: "Terjadi kesalahan saat mengirim laporan.");
    }

    setLoading(false, name: 'addReport');
  }
}
