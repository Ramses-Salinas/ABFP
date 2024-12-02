
class Presupuesto {
  double presupuestoMensual;
  double presupuestoSemestral;
  double presupuestoAnual;
  Map<String, double> presupuestoPorCategoria;
  double metaAhorro;
  String sugerencia;

  Presupuesto({
    required this.presupuestoMensual,
    required this.presupuestoSemestral,
    required this.presupuestoAnual,
    required this.presupuestoPorCategoria,
    required this.metaAhorro,
    required this.sugerencia,
  });

  double calcularPresupuestoTotal() {
    return presupuestoMensual +
        (presupuestoSemestral / 6) +
        (presupuestoAnual / 12);
  }
}
