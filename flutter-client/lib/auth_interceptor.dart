import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:helloworld/main.dart' as main;

class AuthInterceptor extends RequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    var accessToken = await main.storage.read(key: 'jwt');
    return applyHeader(request, "Authorization", "Bearer $accessToken");
    return applyHeader(request, "Content-Type", "application/json");
  }

}
