// import 'package:flutter/widgets.dart';
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
                  builder: (context, state) {
                    final extra = state.extra as int?; // Accediendo al extra
                    return GreenhousesDetailsView(id: extra ?? 0); // Pasar el parámetro al siguiente widget
                  },
                  routes: [
                    
                    GoRoute(
                      path: 'crops', // Ruta secundaria
                      builder: (context, state){
                        final extra = state.extra as int?;
                        return CropsView(id: extra ?? 0);
                      },
                      routes:[
                        GoRoute(
                          path: 'add',
                          builder: (context, state){
                            final extra = state.extra as int?;
                            return CropsAddView(id: extra ?? 0);
                          }
                        ),
                      ],

                    ),

                    GoRoute(
                      path: 'sensors', // Ruta secundaria
                      builder: (context, state){
                        final extra = state.extra as int?;
                        return SensorsView(id: extra ?? 0);
                      },
                      routes: [
                        GoRoute(
                          path: 'config',
                          builder: (context, state) {
                            final extra = state.extra as Map<String, dynamic>?;
                            final greenhouseId = extra?['greenhouseId'] as int?;
                            final sensorId = extra?['sensorId'] as String?;

                            return SensorsConfigView(
                              greenhouseId: greenhouseId ?? 0,
                              sensorId: sensorId ?? '',
                            );
                          },
                        ),
                      ],
                    ),

                    GoRoute(
                      path: 'controls', // Ruta secundaria
                      builder: (context, state){
                        final extra = state.extra as int?;
                        return ControlsView(id: extra ?? 0);
                      },
                      routes: [
                        GoRoute(
                          path: 'details',
                          builder: (context, state) {
                            final extra = state.extra as Map<String, dynamic>?;
                            final greenhouseId = extra?['greenhouseId'] as int?;
                            final controlId = extra?['controlId'] as String?;

                            return ControlDetailsView(
                              greenhouseId: greenhouseId ?? 0,
                              controlId: controlId ?? '',
                            );
                          },
                        ),
                      ],
                    ),

                  ],
                ),


                GoRoute(
                  path: 'edit', // Ruta secundaria
                  builder: (context, state) {
                    final extra = state.extra as int?; // Accediendo al extra
                    return GreenhousesEditView(id: extra ?? 0); // Pasar el parámetro al siguiente widget
                  },
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
              path: '/health',
              builder: (context, state) => const CropHealthView(),
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