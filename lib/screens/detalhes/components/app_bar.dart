import 'package:flutter/material.dart';

AppBar detalhesAppBar() {
  return AppBar(
    elevation: 0,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.share),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {},
      )
    ],
  );
}