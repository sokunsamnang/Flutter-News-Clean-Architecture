import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);
  
  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // Dependencies
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));

  getIt.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(getIt(),getIt())
  );
  
  //UseCases
  getIt.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(getIt())
  );

  getIt.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(getIt())
  );

  getIt.registerSingleton<SavedArticleUseCase>(
    SavedArticleUseCase(getIt())
  );
  
  getIt.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(getIt())
  );


  //Blocs
  getIt.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(getIt())
  );

  getIt.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(getIt(),getIt(),getIt())
  );


}