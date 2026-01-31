
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_shopping/screens/home/home.dart';
import 'package:flutter_live_shopping/utils/route/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GlobalKey<NavigatorState> navigatorKey(Ref ref) {
  return _rootNavigatorKey;
}


@riverpod
GoRouter appRouter(Ref ref) {
  
  return GoRouter(
    initialLocation: Routes.initial.location,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) async {
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.initial.path,
        name: Routes.initial.name,
        redirect: (_, _) => Routes.home.location,
      ),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        builder: (_, _) => const HomeScreen(),
      )
    ],
  );
}
