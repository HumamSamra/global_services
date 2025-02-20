import 'package:auto_route/auto_route.dart';
import 'package:global_services/features/home/view/home.imports.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          path: '/home',
          page: HomeRoute.page,
        ),
      ];
}
