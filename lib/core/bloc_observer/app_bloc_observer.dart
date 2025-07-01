import 'package:bloc/bloc.dart';
import 'package:dailypulsenews/core/utils/logger/logger.dart';

class AppBlocObserver extends BlocObserver{

  @override
  void onEvent(Bloc bloc, Object? event) {
    logI("bloc event: ${bloc.runtimeType} -> $event");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logI("bloc transition: ${bloc.runtimeType} -> $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logE("bloc error: ${bloc.runtimeType} -> $error");
    super.onError(bloc, error, stackTrace);
  }
}