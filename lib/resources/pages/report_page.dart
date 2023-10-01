import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/report_sm_card_widget.dart';
import '/app/controllers/report_controller.dart';
import 'report_detail_page.dart';

class ReportPage extends NyStatefulWidget {
  final Controller controller = Controller();

  static const path = '/report';

  ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends NyState<ReportPage> {
  final ReportController controller = ReportController();
  String? data;
  @override
  init() async {
    setLoading(true, name:'getData');
    super.init();
    data = widget.data();
    controller.getPengaduan(data!).then((value) => setLoading(false, name:'getData'));
    
    setState(() { });
    // controller.status.value = data['status'];
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
                      Text("Pengaduan $data")
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
                      child: Obx(() => controller.pengaduan.value.length > 0
                            ? Column(
                                children: controller.pengaduan.value
                                    .map((data) => ReportSmCardWidget(
                                          onTap: () {
                                            routeTo(ReportDetailPage.path, data: data);
                                          },
                                          description: "${data?.isi}",
                                          date: DateTime.tryParse(
                                              "${data?.tanggal}")!,
                                          status:"${data?.status}",
                                          image: data!.foto!,
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Text( isLoading(name: "getData") ? "Mengambil data...":"Belum ada data."),
                              )),
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
