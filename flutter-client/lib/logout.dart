import 'package:flutter/material.dart';
import 'auth.dart';

class Logout extends StatefulWidget {
  const Logout({ Key? key }) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  Auth authService = Auth();
  void logout() async {
    await authService.logout(context);
  }
  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
          onTap: logout,
          child: const Icon(Icons.logout)
        );
  }
}