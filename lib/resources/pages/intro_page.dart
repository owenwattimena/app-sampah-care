import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/controller.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'login_page.dart';

class IntroPage extends NyStatefulWidget {
  final Controller controller = Controller();

  static const path = '/intro';

  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends NyState<IntroPage> {
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
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'APLIKASI SAMPAH CARE',
            body:
                'Aplikasi inovatif pengaduan sampah guna meningkatkan kesadaran dan efisiensi dalam pengelolahan sampah.',
            image: Image.asset(
              "public/assets/images/sampah_care_1.png",
              width: 160,
            ),
            //getPageDecoration, a method to customise the page style
            // decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'APLIKASI SAMPAH CARE',
            body:
                'Dengan menggunakan teknologi mobile, memungkinkan pelaporan lokasi dan kondisi tempat pembuangan sampah yang tidak sesuai atau berpotensi mencemari lingkungan',
            image: Image.asset(
              "public/assets/images/sampah_care_2.png",
              width: 160,
            ),
            //getPageDecoration, a method to customise the page style
            // decoration: getPageDecoration(),
          ),
        ],
        next: const SizedBox(),
        // next: const Icon(Icons.east),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          routeTo(LoginPage.path, navigationType: NavigationType.pushReplace);
        },
        dotsDecorator: DotsDecorator(
          spacing: EdgeInsets.symmetric(horizontal: 2),
          activeColor: Colors.indigo,
          color: Colors.grey,
          activeSize: Size(20, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
