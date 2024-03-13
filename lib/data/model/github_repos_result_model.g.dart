// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repos_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubReposResultModel _$GithubReposResultModelFromJson(
        Map<String, dynamic> json) =>
    GithubReposResultModel(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      githubRepos: (json['items'] as List<dynamic>)
          .map((e) => GithubRepos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GithubReposResultModelToJson(
        GithubReposResultModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.githubRepos,
    };
