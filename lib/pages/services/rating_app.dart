import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RatingApp extends StatefulWidget {
  final Widget Function(RateMyApp) builder;
  const RatingApp({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  _RatingAppState createState() => _RatingAppState();
}

class _RatingAppState extends State<RatingApp> {
  RateMyApp rateMyApp;
  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
        rateMyApp: RateMyApp(),
        onInitialized: (context, rateMyApp) {
          setState(() => this.rateMyApp = rateMyApp);
        },
        builder: (context) => rateMyApp == null
            ? Center(child: CircularProgressIndicator())
            : widget.builder(rateMyApp),
      );
}
