import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cuestionario extends StatefulWidget {
  @override
  _CuestionarioState createState() => _CuestionarioState();
}

class _CuestionarioState extends State<Cuestionario> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController diasController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();

  // Definimos los dias que se van a mostrar dentro del cuestionario en seleccion de dia
  String selectedDay = '';
  List<String> daysOfWeek = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  // Se manda a llamar el TimePicker
  TimeOfDay pickedTime = TimeOfDay.now();

  Future<void> selectTime() async {
    pickedTime = (await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    ))!;

    if (pickedTime != null) {
      setState(() {
        pickedTime = pickedTime;
      });
    }
  }

  void guardarCuestionario() {
    String nombre = nombreController.text;
    String direccion = direccionController.text;
    String dias = diasController.text;
    String horario = horarioController.text;

    // Accede a la colección 'cuestionarios' en tu base de datos 'cuestionarios'
    CollectionReference cuestionarios =
    FirebaseFirestore.instance.collection('cuestionarios');

    // Crea un nuevo documento para almacenar los datos del cuestionario y para guardar el tianguis con 'nombre'
    cuestionarios
        .doc(nombre)
        .set({
      'nombre': nombre,
      'direccion': direccion,
      'dias': dias,
      'horario': horario,
    })
        .then((value) {
      print('Cuestionario guardado con ID: $nombre');
    })
        .catchError((error) {
      print('Error al guardar el cuestionario: $error');
    });
  }
  //Creacion del cuestionario
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No aparece tu tianguis????'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Escríbenos y lo agregamos :)'),
          Text('Nombre del tianguis'),
          TextField(
            controller: nombreController,
            decoration: InputDecoration(
              hintText: 'Ingresa el nombre aquí',
            ),
          ),
          SizedBox(height: 8),
          Text('Dirección del tianguis'),
          TextField(
            controller: direccionController,
            decoration: InputDecoration(
              hintText: 'Ingresa la dirección aquí',
            ),
          ),
          SizedBox(height: 8),
          Text('Días que se pone'),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Selecciona un día'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var day in daysOfWeek)
                                ListTile(
                                  title: Text(day),
                                  onTap: () {
                                    setState(() {
                                      selectedDay = day;
                                      diasController.text = day;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Selecciona un día',
                  ),
                  controller: TextEditingController(text: selectedDay),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Horario'),
          TextField(
            controller: horarioController,
            decoration: const InputDecoration(
              icon: Icon(Icons.timer),
              hintText: 'Ingresa el horario aquí',
            ),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );
              if (pickedTime != null) {
                setState(() {
                  horarioController.text = pickedTime.format(context);
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            guardarCuestionario();
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
