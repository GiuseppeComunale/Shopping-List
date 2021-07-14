import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/pages/services/database.dart';
import 'package:intl/intl.dart';
import 'package:prototipo_shopping_list/pages/services/view_lista.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';

class HomePageListView extends StatefulWidget {
  const HomePageListView({Key key}) : super(key: key);

  @override
  _HomePageListViewState createState() => _HomePageListViewState();
}

class _HomePageListViewState extends State<HomePageListView> {
  String cibo = 'Cibo';
  String giochi = 'Giochi';
  String vestiti = 'Vestiti';
  String altro = 'Altro';
  String libri = 'Libri';
  String elettronica = 'Elettronica';
  Color colore;
  Icon icona;

  @override
  void initState() {
    super.initState();
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Utenti')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection(cibo)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              refresh();
              return ultimeListe();
            }
          }),
    );
  }

  SingleChildScrollView ultimeListe() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          BodyHomePage(
            tipoPagina: cibo,
            colore: passaggioColore(cibo),
            icona: selezionaIcona(cibo, icona, colore),
          ),
          BodyHomePage(
            tipoPagina: elettronica,
            colore: passaggioColore(elettronica),
            icona: selezionaIcona(elettronica, icona, colore),
          ),
          BodyHomePage(
            tipoPagina: giochi,
            colore: passaggioColore(giochi),
            icona: selezionaIcona(giochi, icona, colore),
          ),
          BodyHomePage(
            tipoPagina: vestiti,
            colore: passaggioColore(vestiti),
            icona: selezionaIcona(vestiti, icona, colore),
          ),
          BodyHomePage(
            tipoPagina: libri,
            colore: passaggioColore(libri),
            icona: selezionaIcona(libri, icona, colore),
          ),
          BodyHomePage(
            tipoPagina: altro,
            colore: passaggioColore(altro),
            icona: selezionaIcona(altro, icona, this.colore),
          ),
        ],
      ),
    );
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
}

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({
    Key key,
    @required this.tipoPagina,
    @required this.colore,
    @required this.icona,
  }) : super(key: key);

  final String tipoPagina;
  final Color colore;
  final Icon icona;

  @override
  _BodyHomePageState createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Utenti')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection(widget.tipoPagina)
            .limit(1)
            .orderBy('Ultima Modifica', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs?.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data?.docs[index];
                  Map data = snapshot.data.docs[index].data();
                  var mydateTime = DateFormat('E, dd/MM/yyyy')
                      .add_jm()
                      .format(documentSnapshot['Ultima Modifica'].toDate())
                      .toString();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 17.0,
                        child: Row(
                          children: [
                            Text(
                              '\t\t\t${widget.tipoPagina}'.toUpperCase(),
                              style: TextStyle(color: widget.colore),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            widget.icona
                          ],
                        ),
                      ),
                      Padding(
                        key: Key(documentSnapshot['Uid']),
                        padding: EdgeInsets.only(top: 6.0),
                        child: Dismissible(
                          key: Key(documentSnapshot['Uid']),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) {
                            return eliminaCard(
                              context,
                              documentSnapshot,
                              widget.tipoPagina,
                            );
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
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  eliminaCard(
    BuildContext context,
    DocumentSnapshot documentSnapshot,
    String tipoPagina,
  ) {
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
                        tipoPagina: tipoPagina)
                    .deleteLista(documentSnapshot['Id Lista']);
                refresh();
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
}
