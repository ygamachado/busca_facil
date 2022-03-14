import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ConfigPage extends StatefulWidget{
  const ConfigPage({Key? key}) : super(key: key);
  @override
  _BuscaPageState createState () => _BuscaPageState();

}

class _BuscaPageState extends State<ConfigPage>{
  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance
        .collection('todo')
        .where('excluido', isEqualTo: false)
        .orderBy('data')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Firebase'),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
        stream: snapshots,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhuma tarefa ainda'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int i) {
              var doc = snapshot.data!.docs[i];
              //var item = doc.data();
              Map<String, dynamic> item = doc.data()! as Map<String, dynamic>;
              // print('todo/${doc.reference.documentID}');

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  isThreeLine: true,
                  leading: IconButton(
                    icon: Icon(
                      item['feito']
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      size: 32,
                    ),
                    onPressed: () => doc.reference.update({
                      'feito': !item['feito'],
                    }),
                  ),
                  title: Text(item['titulo']),
                  subtitle: Text(item['descricao']),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.red[300],
                    foregroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => doc.reference.update({
                        'excluido': true,
                      }),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => modalCreate(context),
        tooltip: 'Adicionar novo',
        child: Icon(Icons.add),
      ),
    );
  }

  modalCreate(BuildContext context) {
    var form = GlobalKey<FormState>();

    var titulo = TextEditingController();
    var descricao = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar nova tarefa'),
          content: Form(
            key: form,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Título'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ex.: Comprar ração',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: titulo,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este campo não pode ser vazio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Descrição'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '(Opcional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    controller: descricao,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            FlatButton(
              onPressed: () async {
                if (form.currentState!.validate()) {
                  await FirebaseFirestore.instance.collection('todo').add({
                    'titulo': titulo.text,
                    'descricao': descricao.text,
                    'feito': false,
                    'data': Timestamp.now(),
                    'excluido': false,
                  });

                  Navigator.of(context).pop();
                }
              },
              color: Colors.green,
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}


