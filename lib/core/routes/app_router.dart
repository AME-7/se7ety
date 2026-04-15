import 'package:go_router/go_router.dart';
import 'package:se7ety/core/routes/routes.dart';

class AppRouter {
  // configuration
  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    routes: [
      // GoRoute(
      //   path: Routes.splash,
      //   builder: (context, state) => const SplashScreen(),
      // ),
      // GoRoute(
      //   path: Routes.onboarding,
      //   builder: (context, state) => const OnboardingScreen(),
      // ),
      // GoRoute(
      //   path: Routes.welcome,
      //   builder: (context, state) => const WelcomeScreen(),
      // ),
      // GoRoute(
      //   path: Routes.login,
      //   builder: (context, state) =>
      //       LoginScreen(userType: state.extra as UserTypeEnum),
      // ),
      // GoRoute(
      //   path: Routes.register,
      //   builder: (context, state) =>
      //       RegisterScreen(userType: state.extra as UserTypeEnum),
      // ),
    ],
  );
}
