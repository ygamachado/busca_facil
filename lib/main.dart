import 'package:busca_facil/configs/app_settings.dart';
import 'package:busca_facil/configs/hive_config.dart';
import 'package:busca_facil/repositories/conta_repository.dart';
import 'package:busca_facil/repositories/favoritas_repository.dart';
import 'package:busca_facil/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  await Firebase.initializeApp(
    name: "busca_facil",
    options: const FirebaseOptions(
        apiKey: "xxxx",
        authDomain: "xxxxxx",
        projectId: "xxxx",
        storageBucket: "xxxxx",
        messagingSenderId: "xxxxxx",
        appId: "xxxxx",
        measurementId: "xxxxx"),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository(
            auth: context.read<AuthService>(),
          ),
        ),
      ],
      child: MeuAplicativo(),
    ),
  );
}
