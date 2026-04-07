// core/network/timeout_client.dart
import 'package:http/http.dart';
import 'package:saglixen/core/contants/api_endpoints.dart';

class TimeoutClient extends BaseClient {
  final Client _inner;
  final Duration _timeout;

  TimeoutClient({
    Client? inner,
    Duration timeout = ApiEndpoints.timeout,
  }) : _inner = inner ?? Client(),
       _timeout = timeout;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _inner.send(request).timeout(_timeout);
  }
}
