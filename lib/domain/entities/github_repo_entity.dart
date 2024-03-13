import 'package:equatable/equatable.dart';

class GithubRepoEntity extends Equatable {
  const GithubRepoEntity({
    required this.url,
    required this.projectName,
    required this.author,
    required this.starCount,
    required this.viewCount,
  });

  final String url;
  final String projectName;
  final String author;
  final int starCount;
  final int viewCount;

  @override
  List<Object?> get props => [
        url,
        projectName,
        author,
        starCount,
        viewCount,
      ];
}
