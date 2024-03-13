part of 'github_repo_bloc.dart';

sealed class GithubRepoState extends Equatable {
  const GithubRepoState();

  @override
  List<Object> get props => [];
}

final class GithubRepoInitial extends GithubRepoState {}

final class GithubRepoInProgress extends GithubRepoState {}

final class GithubRepoFailed extends GithubRepoState {
  const GithubRepoFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [...super.props, errorMessage];
}

final class GithubRepoCompleted extends GithubRepoState {
  const GithubRepoCompleted({required this.repos});

  final List<GithubRepoEntity> repos;

  @override
  List<Object> get props => [...super.props, repos];
}
