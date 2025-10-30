import 'package:dio/dio.dart';
import 'package:world_cue/utils/constants.dart';
import 'package:world_cue/utils/shared_pref.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers[NetworkConstants.authorizationHeaderKey] == true) {
      options.headers.remove(NetworkConstants.authorizationHeaderKey);
      options.headers.addAll(
          {NetworkConstants.authorizationHeaderTag: "Bearer ${SharedPref.getString(authToken)}"});
    }

    super.onRequest(options, handler);
  }
}
