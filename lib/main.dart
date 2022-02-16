import 'package:busca_facil/configs/app_settings.dart';
import 'package:busca_facil/configs/hive_config.dart';
import 'package:busca_facil/repositories/conta_repository.dart';
import 'package:busca_facil/repositories/favoritas_repository.dart';
import 'package:busca_facil/repositories/moeda_repository.dart';
import 'package:busca_facil/services/auth_service.dart';
import 'package:busca_facil/firebase_auth.dart';
import 'package:busca_facil/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => MoedaRepository()),
        ChangeNotifierProvider(
            create: (context) => ContaRepository(
              moedas: context.read<MoedaRepository>(),
            )),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository(
            auth: context.read<AuthService>(),
            moedas: context.read<MoedaRepository>(),
          ),
        ),
      ],
      child: MeuAplicativo(),
    ),
  );
}