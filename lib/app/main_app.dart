import 'package:blog_app/config/routes/route_generator.dart';
import 'package:blog_app/features/Authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blog_app/features/Authentication/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blogs_page.dart';
import 'package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/themes/app_theme.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(AuthenticationCheck());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserIsLoggedIn;
        },
        builder: (context, isLoggedIn) {
          return ConditionalBuilder(
            condition: isLoggedIn,
            builder: (BuildContext context) => const BlogsPage(),
            fallback: (BuildContext context) => const SignUpPage(),
          );
        },
      ),
      initialRoute: '/',
      onGenerateRoute: RoutesGenerator.generateRoute,
    );
  }
}
