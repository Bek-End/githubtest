import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:routeam_test/common/constants/app_data.dart';
import 'package:routeam_test/data/dio_instance.dart';
import 'package:routeam_test/data/model/github_repos_result_model.dart';

part 'github_service_rest.g.dart';

@RestApi(baseUrl: AppData.githubServiseUrl)
abstract class GithubServiceRest {
  @GET('/search/repositories')
  Future<GithubReposResultModel?> getRepos(
    @Query('q') String q,
  );
}

class GithubServiceRestImpl implements GithubServiceRest {
  final _service = _GithubServiceRest(dioInstance(), baseUrl: AppData.githubServiseUrl);

  @override
  Future<GithubReposResultModel?> getRepos(String q) async {
    return await _service.getRepos(q);
  }
}
