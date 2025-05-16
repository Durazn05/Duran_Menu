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
  int _selectedIndex = 0;

  // Lista de páginas para el BottomNavigationBar
  final List<Widget> _pages = const [
    BienvenidaPage(),
    CalculatorPage(),
    MyAppFormu(),
    ImagenInternetPage(),
    BarraProgresoPage(),
  ];

  // Lista de títulos para el AppBar
  final List<String> _titles = [
    'Menú Angel Durán',
    'Calculadora',
    'Formulario IUJO',
    'Imagen de Internet',
    'Barra de Progreso',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _navigateTo(BuildContext context, int index) async {
    setState(() {
      _loading = true;
      _selectedIndex = index;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _loading = false);
    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Cierra el Drawer si está abierto
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación'),
        content: const Text('¿Salir?'),
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
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
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
                leading: const Icon(Icons.home),
                title: const Text('Bienvenida'),
                onTap: () => _navigateTo(context, 0),
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculadora'),
                onTap: () => _navigateTo(context, 1),
              ),
              ListTile(
                leading: const Icon(Icons.format_shapes),
                title: const Text('Formulario IUJO'),
                onTap: () => _navigateTo(context, 2),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Imagen de Internet'),
                onTap: () => _navigateTo(context, 3),
              ),
              ListTile(
                leading: const Icon(Icons.linear_scale),
                title: const Text('Barra de Progreso'),
                onTap: () => _navigateTo(context, 4),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            _pages[_selectedIndex],
            if (_loading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Bienvenida',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculadora',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_shapes),
              label: 'Formulario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Imagen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale),
              label: 'Progreso',
            ),
          ],
        ),
      ),
    );
  }
}

// Página de bienvenida con imagen local y de internet
class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido a mi Menu improvisado :D!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Imagen local (puedes cambiar la ruta si tienes otra imagen)
            Image.asset(
              'assets/LOGO.png',
              height: 120,
            ),
            const SizedBox(height: 16),
            // Imagen de internet adicional
            Image.network(
              'https://as2.ftcdn.net/v2/jpg/05/59/23/93/1000_F_559239377_qpaV2ZLJpT3zrzt16a8R2EsBSQ18vewl.jpg',
              height: 120,
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