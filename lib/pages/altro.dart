import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/account/login_screen.dart';
import 'package:prototipo_shopping_list/pages/services/database.dart';
import 'package:prototipo_shopping_list/pages/services/listpage.dart';
import 'package:prototipo_shopping_list/pages/services/scrivi_lista.dart';
import 'package:prototipo_shopping_list/pages/services/search_service.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';
import 'package:prototipo_shopping_list/standard/my_drawer.dart';
import 'package:random_string/random_string.dart';

class Altro extends StatefulWidget {
  @override
  _AltroState createState() => _AltroState();
}

class _AltroState extends State<Altro> {
  String tipoPagina = 'Altro';
  String titoloLista;
  Color colore = altroTypeColor;
  FirebaseAuth auth = FirebaseAuth.instance;
  String idLista;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser?.uid == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: this.colore,
          centerTitle: true,
          title: Text(tipoPagina,
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ),
        drawer: MyDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add_shopping_cart_rounded,
              color: Colors.grey[850],
              size: 70.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Per iniziare a scrivere le tue liste",
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text("Premi il tasto e accedi con il tuo account",
                style: TextStyle(color: Colors.grey[400])),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    style: TextButton.styleFrom(primary: colore),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    icon: Icon(Icons.login_rounded),
                    label: Text(
                      "Accedi",
                      style: TextStyle(color: colore),
                    ))
              ],
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            parametroNull();
            addDialog(context);
          },
          backgroundColor: this.colore,
          child: Icon(Icons.edit_rounded),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: this.colore,
          title: Text(tipoPagina,
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate:
                      SearchService(tipoPagina: tipoPagina, colore: colore),
                );
              },
            ),
          ],
        ),
        body: ListPage(
          tipoPagina: this.tipoPagina,
          titoloLista: this.titoloLista,
          colore: this.colore,
          idLista: idLista,
        ),
      );
    }
  }

  void parametroNull() {
    this.titoloLista = null;
  }

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Titolo Lista'),
            content: TextField(
              decoration: InputDecoration(hintText: 'Titolo lista'),
              onChanged: (value) {
                this.titoloLista = value;
              },
            ),
            actions: [
              TextButton(
                child: Text('Annulla'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Crea'),
                onPressed: () {
                  if (this.titoloLista == null || this.titoloLista == '') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Errore campo vuoto'),
                          content: Text('Inserisci un titolo per la lista'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Capito'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    idLista = randomAlphaNumeric(28);
                    DatabaseService(
                            uid: FirebaseAuth.instance.currentUser.uid,
                            tipoPagina: tipoPagina,
                            titoloLista: titoloLista,
                            idLista: idLista)
                        .creaListaPerPagina();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScriviLista(
                          titolo: this.titoloLista,
                          tipoPagina: this.tipoPagina,
                          colore: this.colore,
                          idLista: idLista,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        });
  }
}
