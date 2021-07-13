import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/pages/services/database.dart';
import 'package:prototipo_shopping_list/pages/services/view_lista.dart';
import 'package:intl/intl.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';

class ListPage extends StatefulWidget {
  final String tipoPagina;
  final String titoloLista;
  final Color colore;
  final String idLista;

  const ListPage({
    Key key,
    @required this.idLista,
    this.tipoPagina,
    this.titoloLista,
    this.colore,
  }) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future refreshList() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    refreshList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Utenti')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection(widget.tipoPagina)
          .orderBy('Ultima Modifica', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Caricamento...'),
              SizedBox(
                height: 8.0,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.grey[400],
              )
            ],
          ));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs?.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data?.docs[index];
              Map data = snapshot.data.docs[index].data();

              var mydateTime = DateFormat('E, dd/MM/yyyy')
                  .add_jm()
                  .format(documentSnapshot['Ultima Modifica'].toDate())
                  .toString();
              return Padding(
                key: Key(documentSnapshot['Uid']),
                padding: EdgeInsets.only(top: 4.0),
                child: Dismissible(
                  key: Key(documentSnapshot['Uid']),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) {
                    return eliminaCard(context, documentSnapshot,
                        widget.tipoPagina, widget.idLista);
                  },
                  background: deleteIconBackGround(),
                  child: Card(
                    key: Key(documentSnapshot['Uid']),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        "${documentSnapshot['Uid']}",
                        style: TextStyle(fontSize: 17.0),
                      ),
                      subtitle: Text(
                        mydateTime,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 10.0,
                        ),
                      ),
                      onLongPress: () {},
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewLista(
                              data,
                              widget.tipoPagina,
                              widget.colore,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

eliminaCard(BuildContext context, DocumentSnapshot documentSnapshot,
    String tipoPagina, String idLista) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          "Attenzione",
          style: TextStyle(fontSize: 17.0, color: Colors.red),
        ),
        content: Text('Confermi di voler cancellare la lista?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              DatabaseService(
                uid: FirebaseAuth.instance.currentUser.uid,
                tipoPagina: tipoPagina,
                idLista: idLista,
              ).deleteLista(documentSnapshot['Id Lista']);

              Navigator.of(context).pop();
              var card = documentSnapshot['Uid'];
              showSnackBar(context, card);
            },
            child: Text('Conferma'),
          ),
        ],
      );
    },
  );
}
