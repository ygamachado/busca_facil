//import 'package:busca_facil/pages/carteira_page.dart';
//import 'package:busca_facil/pages/configuracoes_page.dart';
//import 'package:busca_facil/pages/favoritas_page.dart';
//import 'package:busca_facil/pages/moedas_page.dart';
import 'package:busca_facil/pages/services_page.dart';
import 'package:flutter/material.dart';

import 'busca_page.dart';
import 'chat_page.dart';
import 'config_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          const BuscaPage(),
          ServicesPage(),
          ChatPage(),
          const ConfigPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.house_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Serviços'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
         backgroundColor: Colors.grey[100],
      ),
    );
  }
}
