import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuscaPage extends StatefulWidget{
  const BuscaPage({Key? key}) : super(key: key);

  @override
  _BuscaPageState createState() => _BuscaPageState();

}

class _BuscaPageState extends State<BuscaPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),

      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),

      ),
    );
  }
  
}

