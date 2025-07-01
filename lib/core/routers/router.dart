import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/feature/headlines/presentation/pages/headlines_page.dart';
import 'package:dailypulsenews/feature/user/user_registration/presentation/page/user_registration_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: UserRegistrationRoute.page,
            path: '/userRegistration',
            initial: true),
        AutoRoute(page: HeadlinesRoute.page, path: '/headlinesScreen'),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
  }
}
