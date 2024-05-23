import 'package:blog_app/config/routes/route_transition.dart';
import 'package:blog_app/config/routes/routes.dart';
import 'package:blog_app/features/Authentication/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/Authentication/presentation/pages/sign_up_page.dart';
import 'package:blog_app/core/shared/error/error_screen.dart';
import 'package:flutter/material.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.initial:
        return AnimatedTransitionRoute(page: const SigninPage());
      case Routes.signin:
        return AnimatedTransitionRoute(page: const SigninPage());
      case Routes.signup:
        return AnimatedTransitionRoute(page: const SignUpPage());
      default:
        return _errorRoute(args.toString());
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return ErrorScreen(
        message: message,
      );
    });
  }
}
