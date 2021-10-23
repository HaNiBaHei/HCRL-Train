import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register/Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Email', hintText: 'Insert your email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password', hintText: 'Insert your password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  await auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  print('Reigstered!!');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                }
              },
              icon: Icon(Icons.add_box_outlined),
              label: Text(
                'Register',
                style: TextStyle(fontSize: 20),
              )),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  await auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  print('Logined!!');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                }
              },
              icon: Icon(Icons.login),
              label: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
