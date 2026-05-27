
import 'package:flutter/material.dart';

class HomePageCalculator extends StatefulWidget {
  const HomePageCalculator({super.key});

  @override
  State<HomePageCalculator> createState() => _HomePageCalculatorState();
}

class _HomePageCalculatorState extends State<HomePageCalculator> {
  // Variable para capturar los valores de la caja de texto
  final TextEditingController txtNum1Controller = TextEditingController();
  
  // Variable para mostrar el resultado dinámicamente en la pantalla
  String _resultado = "0";

  // Procedimiento para mostrar alertas de error
  void alertaError(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text("Alerta de mensaje..."),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            )
          ],
        );
      },
    );
  }

  // Función auxiliar para crear botones uniformes y responsivos
  Widget _buildBoton(String texto, Color color, VoidCallback accion) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Espaciado entre botones
        child: ElevatedButton(
          onPressed: accion,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20), // Ajuste interno
          ),
          child: Text(
            texto,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colores definidos en tu código original
    const colorNumeros = Color.fromARGB(255, 40, 35, 19);
    const colorOperadores = Color.fromARGB(255, 161, 24, 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Ingrese valor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: txtNum1Controller,
                keyboardType: TextInputType.number, // Abre el teclado numérico directamente
                decoration: const InputDecoration(
                  labelText: "Ingrese",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              
              // Contenedor de resultado centrado y limpio
              Center(
                child: Text(
                  "Resultado: $_resultado",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              
              // El teclado se envuelve en un Expanded para que ocupe el resto de la pantalla proporcionalmente
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Columna 1: 7, 4, 1, ,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBoton("7", colorNumeros, () {}),
                          _buildBoton("4", colorNumeros, () {}),
                          _buildBoton("1", colorNumeros, () {}),
                          _buildBoton(",", colorOperadores, () {}),
                        ],
                      ),
                    ),
                    // Columna 2: 8, 5, 2, 0
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBoton("8", colorNumeros, () {}),
                          _buildBoton("5", colorNumeros, () {}),
                          _buildBoton("2", colorNumeros, () {}),
                          _buildBoton("0", colorNumeros, () {}),
                        ],
                      ),
                    ),
                    // Columna 3: 9, 6, 3, =
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBoton("9", colorNumeros, () {}),
                          _buildBoton("6", colorNumeros, () {}),
                          _buildBoton("3", colorNumeros, () {}),
                          _buildBoton("=", colorOperadores, () {}),
                        ],
                      ),
                    ),
                    // Columna 4: /, x, -, +
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBoton("/", colorOperadores, () {}),
                          _buildBoton("x", colorOperadores, () {}),
                          _buildBoton("-", colorOperadores, () {}),
                          _buildBoton("+", colorOperadores, () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Buena práctica: limpiar el controller cuando el widget se destruye
    txtNum1Controller.dispose();
    super.dispose();
  }
}