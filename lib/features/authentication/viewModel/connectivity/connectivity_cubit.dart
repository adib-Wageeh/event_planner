import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityState(true));
  StreamSubscription<InternetConnectionStatus>? _subscription;

  Future<void> initConnectivity() async {
    final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 4),
      checkInterval: const Duration(seconds: 1),
    );
    _subscription =
        customInstance.onStatusChange.listen(
              (InternetConnectionStatus status) {
            switch (status) {
              case InternetConnectionStatus.connected:
              // ignore: avoid_print
                _onConnectionChanged(status);
                break;
              case InternetConnectionStatus.disconnected:
              // ignore: avoid_print
                _onConnectionChanged(status);
                break;
            }
          },
        );
  }

  void _onConnectionChanged(InternetConnectionStatus connectivityResult) {
    if (connectivityResult == InternetConnectionStatus.connected) {
      emit(state.copyWith(isConnected: true));
    } else {
      emit(state.copyWith(isConnected: false));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

}


class ConnectivityState {
  final bool isConnected;

  ConnectivityState(this.isConnected);
  ConnectivityState copyWith({bool? isConnected}) {
    return ConnectivityState(
      isConnected ?? this.isConnected,
    );
  }

}
