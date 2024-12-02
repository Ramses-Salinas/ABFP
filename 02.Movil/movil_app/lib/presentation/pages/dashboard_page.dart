import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/providers/dashboard_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/dashboard_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> tiposDashboard = [
    "Presupuesto vs Gasto Actual",
    "Gasto Mensual",
    "Ahorro vs Objetivo",
  ];

  String tipoSeleccionado = "Presupuesto vs Gasto Actual";

  @override
  void initState() {
    super.initState();
    cargarDashboard();
  }

  void cargarDashboard() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.cargarDashboard(tipoSeleccionado);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    if (provider.isLoading) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: tipoSeleccionado,
                  items: tiposDashboard.map((tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (nuevoTipo) {
                    setState(() {
                      tipoSeleccionado = nuevoTipo!;
                    });
                    cargarDashboard();
                  },
                ),
                const SizedBox(height: 16),


                if (provider.dashboard != null) ...[
                  Text(
                    provider.dashboard.tipo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    provider.dashboard.descripcion,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                ],

                if (tipoSeleccionado == "Presupuesto vs Gasto Actual") ...[
                  SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GraficaBarraGeneral(
                        datos: provider.dashboard.inputs['categorias'],
                        claves: const ['presupuesto', 'gasto'],
                        colores: const [Color(0xFF42A5F5), Color(0xFFEF5350)],
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...provider.dashboard.inputs['categorias']
                      .map<Widget>((categoria) {
                    final progreso =
                        categoria['gasto'] / categoria['presupuesto'];
                    return BarraProgreso(
                      progreso: progreso,
                      label:
                      "${categoria['nombre']} - ${categoria['gasto']} / ${categoria['presupuesto']}",
                    );
                  }).toList(),
                ] else if (tipoSeleccionado == "Gasto Mensual") ...[
                  SizedBox(
                    height: 400,
                    child: GraficaGastoMensualConSelector(
                      datosPorMes: provider.dashboard.inputs['meses'],
                      colorIngreso: const Color(0xFF42A5F5),
                      colorGasto: const Color(0xFFEF5350),
                    ),
                  ),

                ] else if (tipoSeleccionado == "Ahorro vs Objetivo") ...[
                  SizedBox(
                    height: 200,
                    child: IndicadorAhorro(
                      progreso: provider.dashboard.inputs['saldoActual'] /
                          provider.dashboard.inputs['meta'],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

}


