import 'package:flutter/material.dart';
import 'package:routeam_test/presentation/screens/github_repo/repos_screen.dart';
import 'package:rxdart/subjects.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final _searchCtrl = TextEditingController()..addListener(_listen);

  final _activeBtn = BehaviorSubject.seeded(false);

  void _listen() => _activeBtn.value = _searchCtrl.text.length >= 3;

  void _search() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReposScreen(searchText: _searchCtrl.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration(label: Text('Search...')),
                  controller: _searchCtrl,
                ),
              ),
            ),
            StreamBuilder<bool>(
              stream: _activeBtn.stream,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: (snapshot.data ?? false) ? _search : null,
                  child: const Text('Search'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _activeBtn.close();
    super.dispose();
  }
}
