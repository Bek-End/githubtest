import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:routeam_test/presentation/screens/github_repo/bloc/github_repo_bloc.dart';

class BlocScope extends StatelessWidget {
  const BlocScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I.get<GithubRepoBloc>()),
      ],
      child: child,
    );
  }
}
