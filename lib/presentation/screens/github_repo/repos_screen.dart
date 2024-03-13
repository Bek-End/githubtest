import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/common/constants/enums.dart';
import 'package:routeam_test/presentation/screens/github_repo/bloc/github_repo_bloc.dart';
import 'package:routeam_test/presentation/screens/webview/webview_screen.dart';
import 'package:routeam_test/presentation/widgets/empty_widget.dart';
import 'package:routeam_test/presentation/widgets/error_widget.dart';
import 'package:routeam_test/presentation/widgets/loading_widget.dart';
import 'package:routeam_test/presentation/widgets/toast_widget.dart';
import 'package:routeam_test/domain/entities/github_repo_entity.dart';

class ReposScreen extends StatefulWidget {
  const ReposScreen({
    super.key,
    required this.searchText,
  });

  final String searchText;

  @override
  State<ReposScreen> createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  late final MenuController _menuCtrl;
  late final String _searchText;

  @override
  void initState() {
    _searchText = widget.searchText;
    _menuCtrl = MenuController();
    context.read<GithubRepoBloc>().add(GithubRepoSearchEvent(
          searchText: _searchText,
        ));
    super.initState();
  }

  void _reorder(int oldIndex, int newIndex) {
    context.read<GithubRepoBloc>().add(GithubRepoReorderEvent(
          oldIndex: oldIndex,
          newIndex: newIndex,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_searchText),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: MenuAnchor(
              crossAxisUnconstrained: false,
              anchorTapClosesMenu: true,
              controller: _menuCtrl,
              menuChildren: SortType.values
                  .map((sortType) => MenuItemButton(
                        child: Text(sortType.displayName),
                        onPressed: () => context
                            .read<GithubRepoBloc>()
                            .add(GithubRepoSortEvent(sortType: sortType)),
                      ))
                  .toList(),
              child: InkWell(
                onTap: () => _menuCtrl.open(),
                child: const Text('Sort'),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<GithubRepoBloc, GithubRepoState>(
        listenWhen: (p, c) => p != c && c is GithubRepoFailed,
        listener: (_, s) => showToast((s as GithubRepoFailed).errorMessage),
        builder: (context, state) {
          if (state is GithubRepoFailed) {
            return CustomErrorWidget(error: state.errorMessage);
          }

          if (state is! GithubRepoCompleted) return const Loading();

          final repos = state.repos;
          if (repos.isEmpty) return const EmptyWidget();

          return ReorderableListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: repos.length,
            onReorder: _reorder,
            itemBuilder: (context, index) {
              final repoItem = state.repos[index];
              return _RepoCard(
                key: Key(repoItem.url),
                repo: repoItem,
              );
            },
          );
        },
      ),
    );
  }
}

class _RepoCard extends StatelessWidget {
  const _RepoCard({
    super.key,
    required this.repo,
  });

  final GithubRepoEntity repo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repo.projectName, overflow: TextOverflow.ellipsis),
        subtitle: Text(repo.author),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${repo.starCount}'),
                const Icon(Icons.star),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${repo.viewCount}'),
                const Icon(Icons.remove_red_eye),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => WebviewScreen(url: repo.url),
        )),
      ),
    );
  }
}
