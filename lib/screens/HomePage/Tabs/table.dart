import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class tables extends StatelessWidget {
  const tables({Key? key}) : super(key: key);
  //Creacion de widgets desde Firebase
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('cuestionarios').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return SingleChildScrollView(
          child: Column(
            children: documents.map((document) {
              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              final double elevation = data['elevation'] ?? 0.0;
              final String label = data['nombre'] ?? '';
              final String direccion = data['direccion'] ?? '';
              final String dias = data['dias'] ?? '';
              final String horario = data['horario'] ?? '';

              return _CardType1(
                elevation: elevation,
                label: label,
                direccion: direccion,
                dias: dias,
                horario: horario,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;
  final String direccion;
  final String dias;
  final String horario;

  const _CardType1({
    required this.label,
    required this.elevation,
    required this.direccion,
    required this.dias,
    required this.horario,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        side: BorderSide(),
      ),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    direccion,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Días: $dias',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Horario: $horario',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
