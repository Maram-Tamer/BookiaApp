import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register/register_screen.dart';
import 'package:bookia/features/main/presentation/page/main_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static const String splashRoute = '/';
  static const String welcomeRoute = '/welcome';
  static const String signInRoute = '/login';
  static const String signUpRoute = '/register';
  static const String homeRoute = '/main';

  
  static final router = GoRouter(
    routes: [

      GoRoute(path: splashRoute, builder: (context, state) => SplashScreen()),
      
      GoRoute(path: welcomeRoute, builder: (context, state) => WelcomeScreen()),
      
      GoRoute(
        path: signInRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: SignInPage(),
        ),
      ),
      GoRoute(
        path: signUpRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(path: homeRoute, builder: (context, state) => MainAppScreen()),
    ],
  );
}
