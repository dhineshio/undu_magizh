import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/example/presentation/pages/example_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../widgets/main_scaffold.dart';
import 'route_names.dart';

/// App router configuration using GoRouter
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: (context, state) => _ErrorPage(error: state.error),
    redirect: (context, state) {
      // Add global redirect logic here (e.g., authentication)
      return null;
    },
  );

  static final List<RouteBase> _routes = [
    // Splash route
    GoRoute(
      path: RouteNames.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashPage(),
    ),

    // Auth routes
    GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: RouteNames.otp,
      name: RouteNames.otp,
      builder: (context, state) {
        final phoneNumber = state.uri.queryParameters['phone'] ?? '';
        return OtpPage(phoneNumber: phoneNumber);
      },
    ),

    // Main app with bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Explore
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.explore,
              name: RouteNames.explore,
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        // Orders
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.orders,
              name: RouteNames.orders,
              builder: (context, state) => const OrdersPage(),
            ),
          ],
        ),
        // History
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.history,
              name: RouteNames.history,
              builder: (context, state) => const HistoryPage(),
            ),
          ],
        ),
        // Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.profile,
              name: RouteNames.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    // Example feature routes
    GoRoute(
      path: RouteNames.example,
      name: RouteNames.example,
      builder: (context, state) => const ExamplePage(),
    ),

    // Example detail with parameter
    GoRoute(
      path: '${RouteNames.exampleDetail}/:id',
      name: RouteNames.exampleDetail,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return _ExampleDetailPage(id: id);
      },
    ),

    // Add more routes here
  ];
}

// Temporary detail page
class _ExampleDetailPage extends StatelessWidget {
  final String id;

  const _ExampleDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text('ID: $id'),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Error page
class _ErrorPage extends StatelessWidget {
  final Exception? error;

  const _ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.explore),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
