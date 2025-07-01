import 'package:auto_route/auto_route.dart';
import 'package:dailypulsenews/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}
