// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_page.dart';
import 'login.dart';

final storage = FlutterSecureStorage();

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  // Blog about how to implement this app flow: https://carmine.dev/posts/jwtauth/
  @override
  Widget build(BuildContext context) {
    storage.deleteAll();
    return MaterialApp(
      title: 'Slomans App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const Login(key: Key('Login')),
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          // While loading jwt, show progress bar
          if(!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          // jwt could not be found
          if(snapshot.data == "") {
            return Login();
          }

          var str = snapshot.data as String;
          var jwt = str.split(".");

          // Payload doesnt have all three parts, just login again
          if (jwt.length != 3) {
            return Login();
          }

          // Decode the jwt token
          var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
          
          // Calculate expiration, if not expired, navigate to home
          if (DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
            return HomePage("test", str);
          } 

          return Login();
        },
      )
    );
  }
}

