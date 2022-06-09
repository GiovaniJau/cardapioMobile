import 'package:flutter/material.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const UserAccountsDrawerHeader(
          accountEmail: Text("user@mail.com"),
          accountName: Text("Tobias Bartholomeu"),
          currentAccountPicture: CircleAvatar(
            child: Text("TB"),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Minha conta"),
          onTap: () {
            Navigator.pop(context);
            //Navegar para outra página
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_basket),
          title: const Text("Meus pedidos"),
          onTap: () {
            Navigator.pop(context);
            //Navegar para outra página

          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text("Favoritos"),
          onTap: () {
            Navigator.pop(context);
            //Navegar para outra página
          },
        ),
      ],
    ),
  );
}