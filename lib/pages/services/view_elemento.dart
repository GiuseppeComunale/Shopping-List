import 'package:flutter/material.dart';

class ViewElemento extends StatefulWidget {
  final String elemento;
  final bool done;
  final String desc;
  final dynamic prezzo;

  ViewElemento({this.elemento, this.done, this.desc, this.prezzo});

  @override
  _ViewElementoState createState() => _ViewElementoState();
}

class _ViewElementoState extends State<ViewElemento> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 110.0,
                ),
                child: Text(
                  'Dettagli'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[400],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                height: 15.0,
                color: Colors.grey[600],
              ),
              SizedBox(
                height: 66.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 14.0,
                  ),
                  Text(
                    'Elemento: \t\t\t',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blue[400],
                    ),
                  ),
                  Text(widget.elemento),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 14.0,
                  ),
                  Text(
                    "Descrizione:\t\t\t",
                    style: TextStyle(color: Colors.blue[400], fontSize: 17),
                  ),
                  Text(widget.desc),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 14.0,
                  ),
                  Text(
                    "Prezzo:\t\t\t",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue[400],
                    ),
                  ),
                  Text(widget.prezzo == null
                      ? 'Nessun prezzo salvato'
                      : "${widget.prezzo}"),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 14.0,
                  ),
                  Container(
                    child: Text(
                      "Stato acquisto:\t\t\t",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.blue[400],
                      ),
                    ),
                  ),
                  Text(widget.done ? 'Comprato' : 'Non Comprato'),
                ],
              ),
              SizedBox(
                height: 104.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    size: 18.0,
                    color: Colors.grey[500],
                  ),
                  InkWell(
                    hoverColor: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Text(
                      'Torna alla lista',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
