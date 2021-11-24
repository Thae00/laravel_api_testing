import 'package:flutter/material.dart';
import 'package:laravel_api/auth/login_status.dart';
import 'package:laravel_api/ui/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginStatus()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laravel API',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    bool status = Provider.of<LoginStatus>(context).status;

    return Scaffold(
        body: (status)
            ? Container(
                child: Text("MinGaLarPar"),
              )
            : LoginScreen());
  }
}
