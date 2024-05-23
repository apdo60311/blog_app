import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> isConnected();
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final _connection = Connectivity();
  @override
  Future<bool> isConnected() async {
    return await _connection.checkConnectivity().then((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet)) {
        return true;
      } else {
        return false;
      }
    });
  }

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connection.onConnectivityChanged;
}
