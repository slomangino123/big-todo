import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/home_page.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'main.dart' as main;
import 'package:http/http.dart' as http;

class Auth {
  static const String clientId = 'flutter';

  Future login(BuildContext context) async {
    Uri uri;
    if (dotenv.env['ENV']! == "Production")
    {
      var trimmedAuth = dotenv.env['AUTH']!.replaceFirst(RegExp('https://'), '');
      uri = Uri.https(trimmedAuth, "");
    }
    else
    {
      var trimmedAuth = dotenv.env['AUTH']!.replaceFirst(RegExp('http://'), '');
      uri = Uri.http(trimmedAuth, "");
    }

    var scopes = ['openid', 'profile', 'todo.read', 'todo.write'];

    var issuer = await Issuer.discover(uri);
    var client = Client(issuer, clientId);
    
    // create a function to open a browser with an url
    urlLauncher(String url) async {
        if (await canLaunch(url)) {
          await launch(url, forceWebView: true);
        } else {
          throw 'Could not launch $url';
        }
    }
    
    // create an authenticator
    var authenticator = Authenticator(client,
        scopes: scopes,
        port: 4000, urlLancher: urlLauncher);
    
    // starts the authentication
    var credential = await authenticator.authorize();
    
    // close the webview when finished
    closeWebView();

    var userInfo = await credential.getUserInfo();

    var accessToken = (await credential.getTokenResponse()).accessToken;

    // Persist token to secure_storage
    main.storage.write(key: 'jwt', value: accessToken);

    var endSessionUrl = credential.generateLogoutUrl();
    var endSessionUrlString = endSessionUrl.toString();
    main.storage.write(key: 'end-session-url', value: endSessionUrlString);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(userInfo.preferredUsername ?? "user", accessToken!)));
  }

  Future<void> logout(BuildContext context) async {
    await main.storage.delete(key: 'jwt');
    var endSessionUrl = await main.storage.read(key: 'end-session-url');
    if (endSessionUrl != null)
    {
      var uri = Uri.parse(endSessionUrl);

      // This isnt a great solution because the web cookie still lives in the browser.
      await http.post(uri, headers: { 'content-type': 'application/x-www-form-urlencoded' });
    }
    await main.storage.delete(key: 'end-session-url');
    
    // Navigate back to home page without history
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
    
  }
}