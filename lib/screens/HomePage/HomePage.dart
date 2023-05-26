import 'package:flutter/material.dart';
import 'package:plataformav1/screens/HomePage/Tabs/mapa.dart';
import 'package:plataformav1/screens/HomePage/Tabs/search.dart';
import 'package:plataformav1/screens/HomePage/Tabs/table.dart';

// Pagina principal donde se van a llamar las 3 pestañas de la apps

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tu Tianguis CDMX'),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.map),

            ),
            Tab(
              icon: Icon(Icons.table_rows),

            ),
            Tab(
              icon: Icon(Icons.search) ,

            ),
          ]),
        ),
        body: const TabBarView(children: [
          mapa(),
           tables(),
           search(),

        ],)
      ),
    );
  }
}

