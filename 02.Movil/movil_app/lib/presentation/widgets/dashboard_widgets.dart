import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficaBarraGeneral extends StatelessWidget {
  final List<Map<String, dynamic>> datos;
  final List<String> claves;
  final List<Color> colores;

  const GraficaBarraGeneral({
    super.key,
    required this.datos,
    required this.claves,
    required this.colores,
  });

  @override
  Widget build(BuildContext context) {
    if (claves.isEmpty || colores.isEmpty || claves.length != colores.length) {
      throw ArgumentError('Las claves y colores deben ser no vacíos y de la misma longitud.');
    }

    final maxValor = datos.isEmpty
        ? 1
        : datos
        .expand((categoria) => claves.map((clave) => (categoria[clave] ?? 0).toDouble()))
        .reduce((a, b) => a > b ? a : b);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: datos.length * 110,
        height: 600,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxValor > 0 ? maxValor : 1,
            barGroups: datos.asMap().entries.map((entry) {
              final index = entry.key;
              final categoria = entry.value;

              return BarChartGroupData(
                x: index,
                barRods: List.generate(claves.length, (i) {
                  final valor = categoria[claves[i]] ?? 0;
                  return BarChartRodData(
                    toY: valor.toDouble(),
                    color: colores[i],
                    width: 15,
                  );
                }),
              );
            }).toList(),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value < 0 || value >= datos.length) return const SizedBox();
                    return Text(
                      datos[value.toInt()]['nombre'] ?? 'Sin Nombre',
                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: const FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        ),
      ),
    );
  }
}


class BarraProgreso extends StatelessWidget {
  final double progreso;
  final String label;

  const BarraProgreso({Key? key, required this.progreso, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progreso > 1.0 ? 1.0 : progreso,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progreso > 1.0 ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}


//Gasto mensual

class GraficaGastoMensualConSelector extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> datosPorMes;
  final Color colorIngreso;
  final Color colorGasto;

  const GraficaGastoMensualConSelector({
    Key? key,
    required this.datosPorMes,
    required this.colorIngreso,
    required this.colorGasto,
  }) : super(key: key);

  @override
  _GraficaGastoMensualConSelectorState createState() =>
      _GraficaGastoMensualConSelectorState();
}

class _GraficaGastoMensualConSelectorState
    extends State<GraficaGastoMensualConSelector> {
  late String mesSeleccionado;

  @override
  void initState() {
    super.initState();
    mesSeleccionado = widget.datosPorMes.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final categorias = widget.datosPorMes[mesSeleccionado] ?? [];

    return Column(
      children: [
        // Selector de mes
        DropdownButton<String>(
          value: mesSeleccionado,
          items: widget.datosPorMes.keys
              .map((mes) => DropdownMenuItem(
            value: mes,
            child: Text(mes),
          ))
              .toList(),
          onChanged: (nuevoMes) {
            setState(() {
              mesSeleccionado = nuevoMes!;
            });
          },
        ),
        // Gráfico de barras
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 600,
              width: categorias.length * 100,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: categorias
                      .map((e) =>
                  e['ingreso'] > e['gasto'] ? e['ingreso'] : e['gasto'])
                      .reduce((value, element) =>
                  value > element ? value : element)
                      .toDouble(),
                  barGroups: categorias
                      .map((categoria) => BarChartGroupData(
                    x: categorias.indexOf(categoria),
                    barRods: [
                      BarChartRodData(
                        toY: categoria['ingreso'].toDouble(),
                        color: widget.colorIngreso,
                        width: 15,
                      ),
                      BarChartRodData(
                        toY: categoria['gasto'].toDouble(),
                        color: widget.colorGasto,
                        width: 15,
                      ),
                    ],
                  ))
                      .toList(),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                        reservedSize: 40,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value < 0 || value >= categorias.length) {
                            return const SizedBox();
                          }
                          return Text(
                            categorias[value.toInt()]['nombre'],
                            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class IndicadorAhorro extends StatelessWidget {
  final double progreso;

  const IndicadorAhorro({
    super.key,
    required this.progreso,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso hacia la meta: ${(progreso * 100).toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progreso,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ],
    );
  }
}
