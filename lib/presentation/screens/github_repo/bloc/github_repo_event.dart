part of 'github_repo_bloc.dart';

sealed class GithubRepoEvent extends Equatable {
  const GithubRepoEvent();

  @override
  List<Object?> get props => [];
}

final class GithubRepoSearchEvent extends GithubRepoEvent {
  const GithubRepoSearchEvent({required this.searchText});

  final String searchText;

  @override
  List<Object?> get props => [...super.props, searchText];
}

final class GithubRepoReorderEvent extends GithubRepoEvent {
  const GithubRepoReorderEvent({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex, newIndex;

  @override
  List<Object?> get props => [...super.props, oldIndex, newIndex];
}

final class GithubRepoSortEvent extends GithubRepoEvent {
  const GithubRepoSortEvent({
    required this.sortType,
  });

  final SortType sortType;

  @override
  List<Object?> get props => [...super.props, sortType];
}
