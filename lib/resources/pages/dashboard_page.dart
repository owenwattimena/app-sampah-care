import 'package:flutter/material.dart';
import 'package:flutter_app/app/repositories/auth_repository.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/user.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/report_sm_card_widget.dart';
import '../widgets/status_card_widget.dart';
import '/app/controllers/dashboard_controller.dart';
import 'add_report_page.dart';
import 'intro_page.dart';
import 'report_detail_page.dart';
import 'report_page.dart';

class DashboardPage extends NyStatefulWidget {
  static const path = '/dashboard';

  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends NyState<DashboardPage> {
  AuthRepository _authRepository = AuthRepository();
  final DashboardController controller = DashboardController();

  @override
  init() async {
    setLoading(true, name: 'getData');
    super.init();
    controller.user.value = await Auth.user<User>();
    print("${controller.user.value?.nama}");
    await controller.getTotalPengaduan();
    await controller.getPengaduanPending();
    setLoading(false, name: 'getData');
  }

  @override
  void dispose() {
    super.dispose();
  }

  _logout() async {
    await Auth.remove();
    _authRepository.saveToken = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(onPressed: () async {
                      await _logout();
                      routeTo(IntroPage.path, navigationType: NavigationType.pushAndForgetAll);
                    }, icon: Icon(Icons.logout))
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hallo,'),
                      Obx(() => Text("${controller.user.value?.nama ?? ''}")
                          .titleLarge(context)),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 110,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: ThemeColor.get(context).primaryContent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Obx(() => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatusCardWidget(
                              total: controller.totalPengaduan.value.pending,
                              title: 'Pending'),
                          SizedBox(width: 15),
                          StatusCardWidget(
                            total: controller.totalPengaduan.value.proses,
                            title: 'Proses',
                            onTap: () {
                              routeTo(ReportPage.path, data: 'proses');
                              // Navigator.pushNamed(
                              //     context, "${ReportPage.path}?status=proses",
                              //     arguments: "Hello World");
                            },
                          ),
                          SizedBox(width: 15),
                          StatusCardWidget(
                              total: controller.totalPengaduan.value.selesai,
                              title: 'Selesai',
                              onTap: () =>
                                  routeTo(ReportPage.path, data: 'selesai')),
                        ],
                      )),
                ),
              ),
            ),
            Positioned(
              top: 220,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                    color: ThemeColor.get(context).background,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getTotalPengaduan();
                    await controller.getPengaduanPending();
                    setState(() {});
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Laporan Saya'),
                          SizedBox(height: 10),
                          Obx(() => controller.pengaduanPending.value.length > 0
                              ? Column(
                                  children: controller.pengaduanPending.value
                                      .map((data) => ReportSmCardWidget(
                                            onTap: () {
                                              routeTo(ReportDetailPage.path,
                                                  data: data);
                                            },
                                            description: "${data?.isi}",
                                            date: DateTime.tryParse(
                                                    "${data?.tanggal}")!
                                                .add(Duration(hours: 9)),
                                            status: 'Pending',
                                            image: data!.foto!,
                                          ))
                                      .toList(),
                                )
                              : Center(
                                  child: Text(isLoading(name: "getData")
                                      ? "Mengambil data..."
                                      : "Belum ada data."),
                                ))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          routeTo(
            AddReportPage.path,
            onPop: (value) async {
              await controller.getTotalPengaduan();
              await controller.getPengaduanPending();
            },
          );
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
    );
  }
}
