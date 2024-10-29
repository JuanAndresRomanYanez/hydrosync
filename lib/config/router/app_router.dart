import 'package:go_router/go_router.dart';
import 'package:hydrosync/presentation/screens/screens.dart';
import 'package:hydrosync/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(currentChild: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardView(),
              //routes: []
            ),

          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/greenhouses',
              builder: (context, state) => const GreenhousesView(),
              routes: [
                GoRoute(
                  path: 'details', // Ruta secundaria
                  builder: (context, state) => const GreenhousesDetailsView(),
                  routes: [
                    GoRoute(
                      path: 'crops', // Ruta secundaria
                      builder: (context, state) => CropsView(),
                    ),

                    GoRoute(
                      path: 'sensors', // Ruta secundaria
                      builder: (context, state) => SensorsView(),
                    ),

                    GoRoute(
                      path: 'controls', // Ruta secundaria
                      builder: (context, state) => const ControlsView(),
                    ),

                    GoRoute(
                      path: 'configuration', // Ruta secundaria
                      builder: (context, state) => const GreenhouseConfigurationView(),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reports',
              builder: (context, state) => const ReportsView(),
            ),
          ],
        ),


        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/pests',
              builder: (context, state) => const PestsView(),
            ),
          ],
        ),

      ],
    ),


    // GoRoute(
    //   path: '/',
    //   name: 'greenhouses-screen',
    //   builder: (context, state) => GreenhousesScreen(),
    // ),
  ],
);