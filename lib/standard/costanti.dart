import 'package:flutter/material.dart';

Color homePageTypeColor = Colors.blue;
Color profiloTypeColor = Colors.brown[400];
Color ciboTypeColor = Colors.red;
Color elettronicaTypeColor = Colors.green;
Color giochiTypeColor = Colors.orange;
Color vestitiTypeColor = Colors.purple;
Color libriTypeColor = Colors.yellow[600];
Color altroTypeColor = Colors.indigo;
Color valutaAppTypeColor = Colors.deepOrange[300];
String erroreUtenteNonTrovato = 'Utente non trovato. Registrati';
List<String> randImageAccount = [
  'assets/pluto.jpg',
  'assets/pallone.jpg',
  'assets/kon.png',
  'assets/happy.jpg',
  'assets/chopper.png',
  'assets/spongebob.png',
];

const String condividi = 'Condividi come testo';
const String mostraTotaleLista = 'Mostra prezzo totale';
const String azzeraTotaleLista = 'Azzera prezzo totale';

Future buildShowDialog(BuildContext context, String testo) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Ops! E' stato riscontrato un errore",
            style: TextStyle(color: Colors.redAccent, fontSize: 12.0),
          ),
          content: Text(testo),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      });
}

Widget deleteIconBackGround() {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20),
    color: Colors.red,
    child: Icon(
      Icons.delete_rounded,
      color: Colors.white,
    ),
  );
}

showSnackBar(context, card) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Lista "$card" eliminata'),
    ),
  );
}

Icon selezionaIcona(String tipo, Icon icona, Color colore) {
  if (tipo == 'Cibo')
    icona = Icon(
      Icons.local_dining_rounded,
      color: colore,
      size: 17,
    );
  else if (tipo == 'Elettronica')
    icona = Icon(
      Icons.devices_other_rounded,
      color: colore,
      size: 17,
    );
  else if (tipo == 'Giochi')
    icona = Icon(
      Icons.gamepad_rounded,
      color: colore,
      size: 17,
    );
  else if (tipo == 'Vestiti')
    icona = Icon(
      Icons.local_mall_rounded,
      color: colore,
      size: 17,
    );
  else if (tipo == 'Libri')
    icona = Icon(
      Icons.book_rounded,
      color: colore,
      size: 17,
    );
  else if (tipo == 'Altro')
    icona = Icon(
      Icons.add_shopping_cart_rounded,
      color: colore,
      size: 17,
    );

  return icona;
}

erroreCampoVuoto(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Errore campo vuoto',
          style: TextStyle(color: Colors.red),
        ),
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
}

mostraErroreCampoVuoto(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red[700],
    duration: Duration(seconds: 2),
    content: Text(
      'Errore Campo Vuoto',
      style: TextStyle(color: Colors.white),
    ),
  ));
}

erroreListaVuota(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Lista vuota, aggiungi degli elementi per condividerli',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      );
    },
  );
}
