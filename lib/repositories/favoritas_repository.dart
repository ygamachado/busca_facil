//mport 'dart:collection';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cripto_moedas/databases/db_firestore.dart';
//import 'package:cripto_moedas/models/moeda.dart';
//import 'package:cripto_moedas/repositories/moeda_repository.dart';
//import 'package:cripto_moedas/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class FavoritasRepository extends ChangeNotifier {

  late AuthService auth;


  FavoritasRepository({required AuthService auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
   // db = DBFirestore.get();
  }

  _readFavoritas() async {

  }





    notifyListeners();
  }

