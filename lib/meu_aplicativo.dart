import 'package:busca_facil/pages/home_page.dart';
import 'package:busca_facil/widgets/auth_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('todo').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });


    return MaterialApp(
      title: 'Busca Facil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AuthCheck(),
    );
  }
}
