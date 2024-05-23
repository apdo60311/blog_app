import 'package:blog_app/app/main_app.dart';
import 'package:blog_app/core/shared/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/dependency_injection_imports.dart';
import 'package:blog_app/features/Authentication/presentation/bloc/authentication_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            DependencyInjection.serviceLocator.get<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) =>
            DependencyInjection.serviceLocator<AuthenticationBloc>(),
      ),
      BlocProvider(
        create: (context) => DependencyInjection.serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MainApp(),
  ));
}
