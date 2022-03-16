import 'package:flutter/material.dart';
import 'package:openid_client/openid_client_io.dart';
import 'auth.dart';

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Auth')),
        body: const Body(),
      );
  }
}

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Credential credential;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Auth authService = Auth();

  void login() async {
    await authService.login(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: size.width * 0.7,
            child: ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            )
          ),
        ),
    ]);
  }
}