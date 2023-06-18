import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityState(true));
  StreamSubscription<ConnectivityResult>? _subscription;

  Future<void> initConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(state.copyWith(isConnected: false));
    }
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((connectivityResult) => _onConnectionChanged(connectivityResult));
  }

  void _onConnectionChanged(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      emit(state.copyWith(isConnected: false));
    } else {
      emit(state.copyWith(isConnected: true));
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
