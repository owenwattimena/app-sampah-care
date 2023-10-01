import '/resources/pages/report_detail_page.dart';
import '/resources/pages/report_page.dart';
import '/resources/pages/map_page.dart';
import '/resources/pages/add_report_page.dart';
import '/resources/pages/dashboard_page.dart';
import '/resources/pages/register_page.dart';
import '/resources/pages/login_page.dart';
import '/resources/pages/intro_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'guards/auth_route_guard.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
  router.route(IntroPage.path, (context) => IntroPage(), initialRoute: true);
  router.route(HomePage.path, (context) => HomePage());
  // Add your routes here

  // router.route(NewPage.path, (context) => NewPage(), transition: PageTransitionType.fade);



  router.route(LoginPage.path, (context) => LoginPage());

  router.route(RegisterPage.path, (context) => RegisterPage());

  router.route(DashboardPage.path, (context) => DashboardPage(), authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(AddReportPage.path, (context) => AddReportPage(), authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(MapPage.path, (context) => MapPage(), authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(ReportPage.path, (context) => ReportPage(), authPage: true, routeGuards: [AuthRouteGuard()]);

  router.route(ReportDetailPage.path, (context) => ReportDetailPage(), authPage: true, routeGuards: [AuthRouteGuard()]);
});
  
  
  
  
  
  
  
  