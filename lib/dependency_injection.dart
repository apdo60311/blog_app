part of 'dependency_injection_imports.dart';

/// Used for handling dependecy injection logic using **GetIt**
///
/// The `DependencyInjection` class is responsible for setting up and managing the
/// application's dependencies using the GetIt service locator.
/// 1. It initializes the Supabase client.
/// 2. Registers various data sources.
/// 3. Repositories, use cases, and blocs with the service locator.
///
/// The `init()` method is the main entry point for setting up the dependency
/// injection. It calls the `_initAuth()` method to set up the authentication-related
/// dependencies, and then registers the Supabase client and the `AppUserCubit` with
/// the service locator.
///
/// The `_initAuth()` method is responsible for registering the authentication-related
/// dependencies, including the `AuthRemoteDataSource`, `AuthRepository`, `UserSignUp`,
/// `UserSignIn`, `CurrentUser`, and `AuthenticationBloc`.
///
/// The `_initBlog()` method is responsible for registering the blog-related dependencies,
/// including the `BlogRemoteDataSource`, `BlogRepository`, and `CreateBlogUseCase`.

class DependencyInjection {
  static final serviceLocator = GetIt.instance;

  static Future<void> init() async {
    _initAuth();
    _initBlog();
    final supabase = await Supabase.initialize(
        url: Secrets.baseUrl, anonKey: Secrets.apiKey);
    serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

    //! Cubits
    serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());

    //! Core
    serviceLocator
        .registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl());

    //! Hive
    Hive.init((await getApplicationDocumentsDirectory()).path);
    final box = await Hive.openBox('blogs');
    serviceLocator.registerLazySingleton<Box>(() => box);
  }

  static void _initAuth() {
    //! Datasources
    serviceLocator.registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: serviceLocator()));
    //! Repositories
    serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          connectionChecker: serviceLocator(),
        ));
    //! Usecases
    serviceLocator.registerFactory<UserSignUp>(
        () => UserSignUp(repository: serviceLocator()));
    serviceLocator.registerFactory<UserSignIn>(
        () => UserSignIn(repository: serviceLocator()));
    serviceLocator.registerFactory<CurrentUser>(
        () => CurrentUser(repository: serviceLocator()));

    //! Blocs
    serviceLocator.registerLazySingleton(() => AuthenticationBloc(
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),
          currentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
  }

  static void _initBlog() {
    //! Datasources
    serviceLocator.registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDatasourceImpl(client: serviceLocator()));
    serviceLocator.registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(box: serviceLocator()));
    //! Repositories
    serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator()));

    //! Usecases
    serviceLocator.registerFactory<CreateBlogUseCase>(
        () => CreateBlogUseCase(repository: serviceLocator()));
    serviceLocator.registerFactory<GetAllBlogsUsecase>(
        () => GetAllBlogsUsecase(repository: serviceLocator()));

    //! Blocs
    serviceLocator.registerLazySingleton(() => BlogBloc(
          createBlogUseCase: serviceLocator(),
          getAllBlogsUsecase: serviceLocator(),
        ));
  }
}
