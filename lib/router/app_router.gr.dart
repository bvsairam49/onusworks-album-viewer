// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:onusworks_albums_app/src/album_photos/view/album_photos_page.dart'
    as _i1;
import 'package:onusworks_albums_app/src/home/view/home_page.dart' as _i2;
import 'package:onusworks_albums_app/src/login/view/login_page.dart' as _i3;
import 'package:onusworks_albums_app/src/onboard/view/onboard_page.dart' as _i4;
import 'package:onusworks_albums_app/src/splash_screen/view/splash_screen.dart'
    as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AlbumPhotosRoute.name: (routeData) {
      final args = routeData.argsAs<AlbumPhotosRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AlbumPhotosPage(albumId: args.albumId),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    OnboardRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.OnboardPage(),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SplashScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AlbumPhotosPage]
class AlbumPhotosRoute extends _i6.PageRouteInfo<AlbumPhotosRouteArgs> {
  AlbumPhotosRoute({
    required int albumId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          AlbumPhotosRoute.name,
          args: AlbumPhotosRouteArgs(albumId: albumId),
          initialChildren: children,
        );

  static const String name = 'AlbumPhotosRoute';

  static const _i6.PageInfo<AlbumPhotosRouteArgs> page =
      _i6.PageInfo<AlbumPhotosRouteArgs>(name);
}

class AlbumPhotosRouteArgs {
  const AlbumPhotosRouteArgs({required this.albumId});

  final int albumId;

  @override
  String toString() {
    return 'AlbumPhotosRouteArgs{albumId: $albumId}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.OnboardPage]
class OnboardRoute extends _i6.PageRouteInfo<void> {
  const OnboardRoute({List<_i6.PageRouteInfo>? children})
      : super(
          OnboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<SplashRouteArgs> page =
      _i6.PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key}';
  }
}
