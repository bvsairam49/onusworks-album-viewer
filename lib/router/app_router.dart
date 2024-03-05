import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: AlbumPhotosRoute.page),
      ];
}
