import 'package:get_it/get_it.dart';
import 'package:routeam_test/data/services/github_service_rest.dart';
import 'package:routeam_test/domain/usecase/github_repo.usecase.dart';
import 'package:routeam_test/presentation/screens/github_repo/bloc/github_repo_bloc.dart';

abstract class DI {
  static void init() {
    final getIt = GetIt.I;

    getIt.registerSingleton<GithubServiceRest>(GithubServiceRestImpl());
    getIt.registerSingleton<GithubRepoUsecase>(GithubRepoUsecase(getIt.get()));
    getIt.registerSingleton<GithubRepoBloc>(GithubRepoBloc(getIt.get()));
  }

  static Future<void> dispose() async {
    return GetIt.I.reset();
  }
}
