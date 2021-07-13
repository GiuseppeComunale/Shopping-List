import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/account/login_screen.dart';
import 'package:prototipo_shopping_list/pages/services/database.dart';
import 'package:prototipo_shopping_list/pages/services/home_page_listView.dart';
import 'package:prototipo_shopping_list/pages/services/scrivi_lista.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';
import 'package:prototipo_shopping_list/standard/my_drawer.dart';
import 'package:random_string/random_string.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageName = 'Ultime Liste';
  String tipoPagina;
  String titoloLista;
  Color colore;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool searchState = false;
  String idLista;

  List selezionaTipoPagina = [
    'Cibo',
    'Elettronica',
    'Giochi',
    'Vestiti',
    'Libri',
    'Altro'
  ];

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser?.uid == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: homePageTypeColor,
          centerTitle: true,
          title: Text(
            homePageName,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),
        drawer: MyDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.note_add_rounded,
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.login_rounded),
                  label: Text(
                    "Accedi",
                    style: TextStyle(
                      color: colore,
                    ),
                  ),
                )
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
          backgroundColor: homePageTypeColor,
          child: Icon(Icons.edit_rounded),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: homePageTypeColor,
          title: Text(
            homePageName,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),
        body: HomePageListView(),
      );
    }
  }

  void parametroNull() {
    this.titoloLista = null;
    this.tipoPagina = null;
    this.colore = null;
  }

  Color passaggioColore(tipoSelezionato) {
    if (tipoSelezionato == 'Cibo') {
      this.colore = ciboTypeColor;
    } else if (tipoSelezionato == 'Elettronica') {
      this.colore = elettronicaTypeColor;
    } else if (tipoSelezionato == 'Giochi') {
      this.colore = giochiTypeColor;
    } else if (tipoSelezionato == 'Vestiti') {
      this.colore = vestitiTypeColor;
    } else if (tipoSelezionato == 'Libri') {
      this.colore = libriTypeColor;
    } else if (tipoSelezionato == 'Altro') {
      this.colore = altroTypeColor;
    }
    return this.colore;
  }

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Titolo Lista'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: homePageTypeColor,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    decoration: InputDecoration(hintText: '\t\tTitolo lista'),
                    onChanged: (value) {
                      this.titoloLista = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: homePageTypeColor,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonFormField(
                      elevation: 0,
                      hint: Text(
                        '\t\tTipo lista:',
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 33,
                      ),
                      value: tipoPagina,
                      onChanged: (newValue) {
                        setState(() => tipoPagina = newValue);
                      },
                      items: selezionaTipoPagina.map((newValue) {
                        return DropdownMenuItem(
                          value: newValue,
                          child: Text('$newValue'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
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
                  idLista = randomAlphaNumeric(28);
                  if (this.titoloLista == null ||
                      this.titoloLista == '' ||
                      this.tipoPagina == null) {
                    erroreCampoVuoto(context);
                  } else {
                    passaggioColore(this.tipoPagina);
                    DatabaseService(
                      uid: FirebaseAuth.instance.currentUser.uid,
                      tipoPagina: tipoPagina,
                      titoloLista: titoloLista,
                      idLista: idLista,
                    ).creaListaPerPagina();
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
