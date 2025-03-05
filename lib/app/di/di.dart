import 'package:dio/dio.dart';
import 'package:fashion_hub/features/Product/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:fashion_hub/features/Product/data/repository/product_remote_repository.dart';
import 'package:fashion_hub/features/Product/domain/repository/product_repository.dart';
import 'package:fashion_hub/features/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/delete_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/upload_image_usecase.dart';
import 'package:fashion_hub/features/Product/presentation/view_model/bloc/product_bloc.dart';
import 'package:fashion_hub/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:fashion_hub/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:fashion_hub/features/home/presentation/view_model/home_cubit.dart';
import 'package:fashion_hub/features/onboarding_screen/presentation/view_model/onboarding_cubit.dart';
import 'package:fashion_hub/features/splash/presentation/view_model/splash_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/shared_prefs/token_shared_prefs.dart';
import '../../core/network/api_service.dart';
import '../../core/network/hive_service.dart';
import '../../features/auth/data/data_source/remote_datasource/user_remote_data_source.dart';
import '../../features/auth/data/repository/user_remote_repository.dart';
import '../../features/auth/domain/use_case/create_user_usecase.dart';
import '../../features/auth/domain/use_case/login_user_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initSharedPreferences();
  _initApiService();
  _initProductDependencies(); // 🔥 Ensure Product Dependencies are registered
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

  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

void _initProductDependencies() {
  // Register ProductRemoteDataSource
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(getIt<Dio>()),
  );

  // Register ProductRepository (Implements IProductRepository)
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRemoteRepository(getIt<ProductRemoteDataSource>()),
  );

  // ✅ Register GetAllProductUseCase with required dependencies
  getIt.registerLazySingleton<GetAllProductUseCase>(
    () => GetAllProductUseCase(
      productRepository: getIt<IProductRepository>(), // Ensure correct repo type
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Ensure token is passed
    ),
  );

  // ✅ Register DeleteProductUseCase with required dependencies
  getIt.registerLazySingleton<DeleteProductUsecase>(
    () => DeleteProductUsecase(
      productRepository: getIt<IProductRepository>(), // Ensure correct repo type
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Ensure token is passed
    ),
  );

  // Register UploadProductImageUsecase
  getIt.registerLazySingleton<UploadProductImageUsecase>(
    () => UploadProductImageUsecase(getIt<IProductRepository>()),
  );

  // Register ProductBloc
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      getAllProductUseCase: getIt<GetAllProductUseCase>(),
      deleteProductUsecase: getIt<DeleteProductUsecase>(),
      uploadProductImageUsecase: getIt<UploadProductImageUsecase>(),
    ),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(authRepository: getIt<UserRemoteRepository>()),
  );
}

void _initAuthDependencies() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UserRemoteRepository>(
    () => UserRemoteRepository(getIt<UserRemoteDataSource>()),
  );

  getIt.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(userRepository: getIt<UserRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(getIt<UserRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      createUserUsecase: getIt<CreateUserUsecase>(),
      uploadImageUseCase: getIt<UploadImageUseCase>(),
    ),
  );

  getIt.registerLazySingleton<LoginUserUsecase>(
    () => LoginUserUsecase(
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
      userRepository: getIt<UserRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUserUsecase: getIt<LoginUserUsecase>(),
    ),
  );
}

void _initSplashScreenDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}

void _initOnboardingScreenDependencies() {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
