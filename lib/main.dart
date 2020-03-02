
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/firebase_data_source.dart';
import 'data/patient_repository.dart';
import 'features/login_page.dart';
import 'features/patient_manage_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PatientRepository>(
          create: (context) => PatientRepository(
            FireBaseDataSource(
              Firestore.instance
            )
          ),
        )
      ],
      child: MaterialApp(
        title: 'Beautiful Care',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
            background: Colors.white,
            onBackground: Colors.black87
          )
        ),
        onGenerateRoute: (setting) {
          switch(setting.name) {
            case PatientManagePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (context) => PatientManagePage());
            default:
              return MaterialPageRoute(builder: (context) => LoginPage() );
          }
        },
        initialRoute: '/',
      ),
    );
  }
}
