import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts_app/features/posts/data/repositories/posts_repository_implement.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_post_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Features - posts

  //Bloc
  getIt.registerFactory(() => PostsBloc(getAllPosts: getIt()));
  getIt.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: getIt(), deletePost: getIt(), updatePost: getIt()));

  //UseCases
  getIt.registerLazySingleton(() => GetAllPostsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddPostUseCase(getIt()));
  getIt.registerLazySingleton(() => DeletePostUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdatePostUseCase(getIt()));

  //Repositories
  getIt.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt()));

  //DataSources
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: getIt()));

  //! core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
