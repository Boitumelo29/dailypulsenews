import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/feature/article/presentation/page/article_detail_page.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:dailypulsenews/feature/headlines/presentation/pages/headlines_wrapper.dart';
import 'package:dailypulsenews/feature/headlines/presentation/pages/headlines_view.dart';
import 'package:dailypulsenews/feature/splash/splash_screen.dart';
import 'package:dailypulsenews/feature/user/user_registration/presentation/page/user_registration_page.dart';
import 'package:dailypulsenews/feature/user/user_registration/presentation/page/user_registration_view.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/splashPage', initial: true),
        AutoRoute(
          page: UserRegistrationWrapperRoute.page,
          path: '/userRegistration',
          children: [ AutoRoute(
            page: UserRegistrationRoute.page,
            path: '',
          ),]
        ),
        AutoRoute(
            page: HeadlinesWrapperRoute.page,
            path: '/headlinesScreen',
            children: [
              AutoRoute(
                page: HeadlinesRoute.page,
                path: '',
              ),
              AutoRoute(
                page: ArticleDetailRoute.page,
                path: '',
              ),
            ]),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
  }
}
