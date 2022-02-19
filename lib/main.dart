import 'package:flutter/material.dart';
import 'package:historico_academico/Presentation/Enrolled/create.dart';
import 'package:historico_academico/Presentation/Enrolled/edit.dart';
import 'package:historico_academico/Presentation/User/index.dart';
import 'package:historico_academico/Presentation/User/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Historico academico',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: loginRoute(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login' : (context) => const LoginPage(),
        '/user/all': (context) => const UserIndex(),
        'enrolled/create': (context) => const CreateEnrolled(),
        'enrolled/update': (context) => const EditEnrolled(),
      },
    );
  }
}
String loginRoute() => '/login';
String userIndexRoute() => '/user/all';
String createEnrolledRoute() => 'enrolled/create';
String updateEnrolledRoute() => 'enrolled/update';
