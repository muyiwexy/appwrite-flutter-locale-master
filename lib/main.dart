import 'package:ecommerce/pages/homepage.dart';
import 'package:ecommerce/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/authenticate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => Authenticate(),
      lazy: false,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Authenticate>(
          builder: (context, state, child) {
            if (state.isLoggedin == true) {
              return Mainhomepage(user: state.user);
            } else {
              return const Login();
            }
          },
        ),
      ));
}
