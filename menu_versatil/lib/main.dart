import 'package:flutter/material.dart';
import 'calcu.dart';
import 'formu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Angel Durán',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _loading = false;

  Future<void> _navigateTo(BuildContext context, Widget page) async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _loading = false);
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación'),
        content: const Text('¿Seguro que te quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sí'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menú Angel Durán'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculadora'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateTo(context, const CalculatorPage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_shapes),
                title: const Text('Formulario IUJO'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateTo(context, const MyAppFormu());
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Imagen de Internet'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateTo(context, const ImagenInternetPage());
                },
              ),
              ListTile(
                leading: const Icon(Icons.linear_scale),
                title: const Text('Barra de Progreso'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateTo(context, const BarraProgresoPage());
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            const Center(
              child: Text(
                '¡Bienvenido a mi Menu improvisado :D!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            if (_loading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Página para mostrar la imagen de internet
class ImagenInternetPage extends StatelessWidget {
  const ImagenInternetPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imagen de Internet')),
      body: Center(
        child: Image.network(
          'https://th.bing.com/th/id/R.a27f9d49715266cd8f4e9b8649a18075?rik=xJ5G7buWmyOo9A&riu=http%3a%2f%2ftienda.tuexpressonline.com%2fweb%2fimage%2fproduct.template%2f6005%2fimage_1024%3funique%3dffe64f8&ehk=c6rxX25qPvCOMIdjxZ9auYp3kNBEfLQ9SLBnq9s8jUY%3d&risl=&pid=ImgRaw&r=0',
          height: 180,
        ),
      ),
    );
  }
}

// Página para mostrar la barra de progreso y los botones
class BarraProgresoPage extends StatefulWidget {
  const BarraProgresoPage({super.key});
  @override
  State<BarraProgresoPage> createState() => _BarraProgresoPageState();
}

class _BarraProgresoPageState extends State<BarraProgresoPage> {
  double _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barra de Progreso')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Barra de progreso:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _progress = (_progress - 0.1).clamp(0.0, 1.0);
                    });
                  },
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _progress = (_progress + 0.1).clamp(0.0, 1.0);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para llamar a formu.dart correctamente
class MyAppFormu extends StatelessWidget {
  const MyAppFormu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario IUJO')),
      body: const FormularioCapturaDatos(),
    );
  }
}