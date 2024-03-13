import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routeam_test/common/di/bloc_scope.dart';
import 'package:routeam_test/common/di/di.dart';
import 'package:routeam_test/presentation/screens/github_repo/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DI.init();
  runApp(const BlocScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const SearchScreen(),
      builder: (context, child) {
        return Overlay(initialEntries: [
          OverlayEntry(builder: (context) {
            FToast().init(context);
            return child ?? const SizedBox.shrink();
          }),
        ]);
      },
    );
  }
}
