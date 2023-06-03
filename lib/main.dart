import 'package:flutter/material.dart';
import 'package:invoice/utils/routes/routes.dart';
import 'package:invoice/utils/routes/routes_name.dart';
import 'package:invoice/view_model/auth_view_model.dart';
import 'package:invoice/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>AuthViewModel()),
          ChangeNotifierProvider(create: (_)=>UserViewModel()),
        ],
      child: MaterialApp(
        title: 'Invoice App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        initialRoute: RoutesName.splash,
        // initialRoute: RoutesName.home,  // this is initial route - redirect to home
        onGenerateRoute: Routes.generateRoute,
      ),
    );

  }
}
