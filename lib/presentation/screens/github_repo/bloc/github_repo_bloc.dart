import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/common/constants/enums.dart';
import 'package:routeam_test/domain/entities/github_repo_entity.dart';
import 'package:routeam_test/domain/usecase/github_repo.usecase.dart';

part 'github_repo_event.dart';
part 'github_repo_state.dart';

class GithubRepoBloc extends Bloc<GithubRepoEvent, GithubRepoState> {
  GithubRepoBloc(GithubRepoUsecase githubRepoUsecase)
      : _githubRepoUsecase = githubRepoUsecase,
        super(GithubRepoInitial()) {
    on<GithubRepoSearchEvent>(_getRepos);
    on<GithubRepoReorderEvent>(_reorder);
    on<GithubRepoSortEvent>(_sortRepos);
  }

  final GithubRepoUsecase _githubRepoUsecase;

  void _getRepos(
      GithubRepoSearchEvent event, Emitter<GithubRepoState> emit) async {
    try {
      final connectivity = Connectivity();
      final connect = await connectivity.checkConnectivity();
      if (connect != ConnectivityResult.mobile &&
          connect != ConnectivityResult.wifi) {
        throw const SocketException('No connection');
      }

      emit(GithubRepoInProgress());
      final repos = await _githubRepoUsecase.getGithubRepos(event.searchText);
      emit(GithubRepoCompleted(repos: repos));
    } on SocketException {
      emit(const GithubRepoFailed(errorMessage: 'No connection'));
    } catch (e) {
      emit(const GithubRepoFailed(errorMessage: 'Error'));
    }
  }

  void _reorder(GithubRepoReorderEvent event, Emitter<GithubRepoState> emit) {
    final oldIndex = event.oldIndex;
    final newIndex =
        oldIndex < event.newIndex ? event.newIndex - 1 : event.newIndex;

    final repos = (state as GithubRepoCompleted).repos;
    final repoSwap = repos[oldIndex];

    repos.removeAt(oldIndex);
    repos.insert(newIndex, repoSwap);

    emit(GithubRepoCompleted(repos: repos));
  }

  void _sortRepos(GithubRepoSortEvent event, Emitter<GithubRepoState> emit) {
    if (state is! GithubRepoCompleted) return;
    final sortedList =
        List<GithubRepoEntity>.from((state as GithubRepoCompleted).repos);

    switch (event.sortType) {
      case SortType.star:
        sortedList.sort(((a, b) => a.starCount.compareTo(b.starCount)));
        break;
      case SortType.view:
        sortedList.sort(((a, b) => a.viewCount.compareTo(b.viewCount)));
        break;
      case SortType.starDESC:
        sortedList.sort(((a, b) => b.starCount.compareTo(a.starCount)));
        break;
      case SortType.viewDESC:
        sortedList.sort(((a, b) => b.viewCount.compareTo(a.viewCount)));
        break;
    }

    emit(GithubRepoCompleted(repos: sortedList));
  }
}
