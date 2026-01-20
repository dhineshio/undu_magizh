import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/example/presentation/pages/example_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
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

    // Home route
    GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) => const _HomePage(),
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

// Temporary home page
class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Undu Magizh'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Text(
              'Project Setup Complete! ✨',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'GoRouter is configured and ready to use.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.pushNamed(RouteNames.example);
              },
              icon: const Icon(Icons.rocket_launch),
              label: const Text('Go to Example Page'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                context.pushNamed(RouteNames.login);
              },
              icon: const Icon(Icons.phone_android),
              label: const Text('Test Login Page'),
            ),
          ],
        ),
      ),
    );
  }
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
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
