import 'package:flutter_live_shopping/utils/route/app_route.dart';
import 'package:flutter_live_shopping/utils/route/route_names.dart';

class Routes {
  static AppRoute get initial => const AppRoute('/', '/', 'initial');

  

  static AppRoute get home => AppRoute(
    '/${RouteNames.home}',
    '${initial.location}${RouteNames.home}',
    RouteNames.home,
  );

  
}
