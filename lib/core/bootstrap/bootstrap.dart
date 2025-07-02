import 'package:dailypulsenews/core/app/app.dart';
import 'package:dailypulsenews/core/bloc_observer/app_bloc_observer.dart';
import 'package:dailypulsenews/core/dependency_injection/di.dart';
import 'package:dailypulsenews/core/init/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> bootstrap() async {
   await AppInitializer.initialize();
  setupDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(App());
}