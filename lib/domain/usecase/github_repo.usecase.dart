import 'package:routeam_test/data/model/github_repos_result_model.dart';
import 'package:routeam_test/data/services/github_service_rest.dart';
import 'package:routeam_test/domain/entities/github_repo_entity.dart';

class GithubRepoUsecase {
  const GithubRepoUsecase(GithubServiceRest githubService)
      : _githubService = githubService;

  final GithubServiceRest _githubService;

  Future<List<GithubRepoEntity>> getGithubRepos(String searchText) async {
    final repos = <GithubRepoEntity>[];
    final res = await _githubService.getRepos(searchText);
    for (var repo in (res?.githubRepos ?? <GithubRepos>[])) {
      repos.add(GithubRepoEntity(
        url: repo.htmlUrl,
        projectName: repo.name,
        author: repo.owner.login,
        starCount: repo.stargazersCount,
        viewCount: repo.watchersCount,
      ));
    }
    return repos;
  }
}
