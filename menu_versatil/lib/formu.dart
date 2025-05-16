import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color principal de la app
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulario de Captura de Datos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormularioCapturaDatos(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Acción del botón flotante
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}

class FormularioCapturaDatos extends StatefulWidget {
  const FormularioCapturaDatos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioCapturaDatosState createState() => _FormularioCapturaDatosState();
}

class _FormularioCapturaDatosState extends State<FormularioCapturaDatos> {
  String nombre = '';
  bool trabaja = false;
  bool estudia = false;
  String genero = '';
  bool activarNotificaciones = false;
  double precioEstimado = 0;
  late DateTime fecha;
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();

  @override
  void dispose() {
    fechaController.dispose();
    horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen en la parte superior
          Center(
            child: Image.asset(
              'assets/LOGO.png',
              height: 100, // Ajusta la altura de la imagen
            ),
          ),
          SizedBox(height: 10),
          // Título del formulario
          Center(
            child: Text(
              'Instituto Universitario Jesús Obrero\nExtensión Barquisimeto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          // Campo de texto para el nombre
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                nombre = value;
              });
            },
          ),
          SizedBox(height: 20),
          // Opciones de trabajo y estudio
          Text('Seleccione una opción:', style: TextStyle(fontWeight: FontWeight.bold)),
          CheckboxListTile(
            title: Text('Trabaja'),
            value: trabaja,
            onChanged: (value) {
              setState(() {
                trabaja = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Estudia'),
            value: estudia,
            onChanged: (value) {
              setState(() {
                estudia = value!;
              });
            },
          ),
          // Selección de género
          Text('Seleccione el género:', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile(
            title: Text('Masculino'),
            value: 'Masculino',
            groupValue: genero,
            onChanged: (value) {
              setState(() {
                genero = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('Femenino'),
            value: 'Femenino',
            groupValue: genero,
            onChanged: (value) {
              setState(() {
                genero = value!;
              });
            },
          ),
          // Activar notificaciones
          SwitchListTile(
            title: Text('Activar Notificaciones'),
            value: activarNotificaciones,
            onChanged: (value) {
              setState(() {
                activarNotificaciones = value;
              });
            },
          ),
          // Slider para precio estimado
          Text('Seleccione Precio Estimado', style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: precioEstimado,
            min: 0,
            max: 100,
            divisions: 10,
            label: precioEstimado.round().toString(),
            onChanged: (value) {
              setState(() {
                precioEstimado = value;
              });
            },
          ),
          SizedBox(height: 20),
          // Campo de texto para la fecha
          TextField(
            controller: fechaController,
            decoration: InputDecoration(
              labelText: 'Introduzca la Fecha',
              border: OutlineInputBorder(),
            ),
            readOnly: true, // Evita que el teclado se abra
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  fecha = picked;
                  fechaController.text =
                      "${picked.day}/${picked.month}/${picked.year}";
                });
              }
            },
          ),
          SizedBox(height: 20),
          // Campo de texto para la hora
          TextField(
            controller: horaController,
            decoration: InputDecoration(
              labelText: 'Seleccione la Hora',
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: () async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() {
                  horaController.text = picked.format(context);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}