import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plataformav1/screens/SettingsPage/SettingsScreen.dart';
import 'package:plataformav1/screens/SettingsPage/Cuestionario.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          iconTheme: theme.iconTheme,
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Busca Tu Tianguis',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cuestionarios')
                .where('nombre', isGreaterThanOrEqualTo: _searchText) //Creacion de parametros de busqueda
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final data = document.data() as Map<String, dynamic>;
                  final titulo = data['nombre'] as String;
                  final direccion = data['direccion'] as String;
                  final dias = data['dias'] as String;
                  final horario = data['horario'] as String;

                  return Card(
                    child: ListTile(
                      title: Text(titulo),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(direccion),
                          const SizedBox(height: 8.0),
                          Text('Días: $dias'),
                          Text('Horario: $horario'),
                        ],
                      ),
                    ),
                  );

                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// botones///
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            child: const Icon(Icons.settings),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Cuestionario();
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
