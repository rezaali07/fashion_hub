import 'package:dio/dio.dart';
import 'package:fashion_hub/features/onboarding_screen/presentation/view_model/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_hub/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_cubit.dart';
import 'package:fashion_hub/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/remote_datasource/user_remote_data_source.dart';
import '../../features/auth/data/repository/user_remote_repository.dart';
import '../../features/auth/domain/use_case/create_user_usecase.dart';
import '../../features/auth/domain/use_case/login_user_usecase.dart';
import '../../app/shared_prefs/token_shared_prefs.dart';

// Lazy Singleton - One Object Used again and again
// Factory - New Object for each call (used for Bloc and Cubit)

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initSharedPreferences();
  _initApiService();
  _initHomeDependencies();
  _initAuthDependencies();
  _initSplashScreenDependencies();
  _initOnboardingScreenDependencies();
}

Future<void> _initHiveService() async {
  final hiveService = HiveService();
  getIt.registerLazySingleton<HiveService>(() => hiveService);
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register TokenSharedPrefs
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
}

void _initApiService() {
  // Register Dio instance via ApiService
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

void _initHomeDependencies() {
  // Register HomeCubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}

void _initAuthDependencies() {
  // Register UserRemoteDataSource
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(getIt<Dio>()),
  );

  // Register UserRemoteRepository
  getIt.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(getIt<UserRemoteDataSource>()),
  );

  // Register CreateUserUsecase
  getIt.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(userRepository: getIt<UserRemoteRepository>()),
  );

  // Register UploadImageUseCase
  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(getIt<UserRemoteRepository>()),
  );

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      createUserUsecase: getIt<CreateUserUsecase>(),
      uploadImageUseCase: getIt<UploadImageUseCase>(),
    ),
  );

  // Register LoginUserUsecase
  getIt.registerLazySingleton<LoginUserUsecase>(
    () => LoginUserUsecase(
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      userRepository: getIt<UserRemoteRepository>(),
    ),
  );

  // Register LoginBloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUserUsecase: getIt<LoginUserUsecase>(),
    ),
  );
}

void _initSplashScreenDependencies() {
  // Register SplashCubit
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}

void _initOnboardingScreenDependencies() {
  // Register OnboardingCubit
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
