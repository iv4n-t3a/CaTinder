import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class NetworkStatusObserver {
  final Connectivity _connectivity = Connectivity();
  final VoidCallback? onNoInternet;

  NetworkStatusObserver({this.onNoInternet}) {
    try {
      _connectivity
          .checkConnectivity()
          .then((result) => _updateConnectivityStatus(result));
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  Future<void> _updateConnectivityStatus(
      List<ConnectivityResult> result) async {
    if (result.isEmpty || result.contains(ConnectivityResult.none)) {
      onNoInternet?.call();
    }
  }
}
