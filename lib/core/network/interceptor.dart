import 'package:dio/dio.dart';
import 'package:world_cue/core/storage/shared_pref.dart';
import 'package:world_cue/core/utils/constants.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers[NetworkConstants.authorizationHeaderKey] == true) {
      options.headers.remove(NetworkConstants.authorizationHeaderKey);
      options.headers.addAll({
        NetworkConstants.authorizationHeaderTag:
            "Bearer ${SharedPref.getString(authToken)}",
      });
    }

    super.onRequest(options, handler);
  }
}
