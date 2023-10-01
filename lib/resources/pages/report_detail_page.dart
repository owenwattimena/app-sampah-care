import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:flutter_app/resources/pages/map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';
import '../../app/models/pengaduan.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/report_detail_controller.dart';

class ReportDetailPage extends NyStatefulWidget {
  final Controller controller = Controller();

  static const path = '/report-detail';

  ReportDetailPage({Key? key}) : super(key: key);

  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends NyState<ReportDetailPage> {
  final ReportDetailController controller = ReportDetailController();

  Pengaduan? report;
  @override
  init() async {
    super.init();
    setState(() {
      report = widget.data();
      setLoading(true, name: 'tanggapan');
      controller
          .getTanggapan(report!.id!)
          .then((value) => setLoading(false, name: 'tanggapan'));
    });
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
                      Text("Pengaduan")
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: (report != null)
                                  ? Image.network(
                                      getEnv('APP_URL') + "/${report!.foto!}",
                                    )
                                  : null),
                          SizedBox(height: 15),
                          (report!=null) ? Text(DateTime.tryParse("${report?.tanggal}")!.add(Duration(hours: 9)).toString()).fontWeightBold() : SizedBox(),
                          Text("${report?.isi}").setColor(context,
                              (color) => ThemeColor.get(context).textGrey),
                          SizedBox(height: 10),
                          Text("${report?.status}"),
                          SizedBox(height: 15),
                          Obx(() => (controller.tanggapan.value?.id == null) ? SizedBox() : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Tanggapan').fontWeightBold(),
                              
                                  Text("${controller.tanggapan.value?.isi}")
                                      .setColor(
                                          context,
                                          (color) => ThemeColor.get(context)
                                              .textGrey),
                              (controller.tanggapan.value?.foto == null) ? SizedBox() :
                              Image.network(
                                      getEnv('APP_URL') + "/${controller.tanggapan.value?.foto}",
                                    ),
                            ],
                          )),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              routeTo(MapPage.path,
                                  data: Position(
                                      latitude: report!.latitude!,
                                      longitude: report!.longitude!,
                                      accuracy: 0,
                                      altitude: 0,
                                      heading: 0,
                                      speed: 0,
                                      speedAccuracy: 0,
                                      timestamp: DateTime.now()));
                            },
                            style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size(130, 40)),
                              backgroundColor: MaterialStateProperty.all(
                                  ThemeColor.get(context).secondaryAccent),
                            ),
                            child: Text('Buka Di Peta'),
                          ),
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
}
