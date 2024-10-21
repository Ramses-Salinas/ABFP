from app.dominio.modelo_prediccion import ModeloPrediccion

class ServicioPredicciones:
    def __init__(self, repositorio_datos):
        self.repositorio_datos = repositorio_datos

    def realizar_prediccion(self, datos_entrada):
        # 1. Obtener datos históricos del repositorio
        datos_historicos = self.repositorio_datos.obtener_datos(datos_entrada["usuario_id"])

        # 2. Preprocesar datos de entrada y combinarlos con datos históricos
        datos_procesados = self._preprocesar_datos(datos_entrada, datos_historicos)

        # 3. Realizar la predicción (simulado por ahora)
        prediccion = self._predecir(datos_procesados)

        # 4. Convertir la predicción en un formato legible
        modelo_prediccion = ModeloPrediccion(
            gastos_futuros=prediccion["gastos_futuros"],
            saldo_futuro=prediccion["saldo_futuro"],
            habitos_financieros=prediccion["habitos_financieros"],
            tendencias_gastos=prediccion["tendencias_gastos"]
        )

        return modelo_prediccion

    def _preprocesar_datos(self, datos_entrada, datos_historicos):
        # Lógica de preprocesamiento de datos (simulado por ahora)
        return {
            "gastos_promedio_mensual": 300.00,
            "tendencia_gastos": "estable"
        }

    def _predecir(self, datos_procesados):
        # Simular la predicción del modelo de IA
        return {
            "gastos_futuros": 350.00,  # Valor simulado
            "saldo_futuro": 2200.00,  # Valor simulado
            "habitos_financieros": ["Gasto frecuente en alimentos", "Mayor gasto los fines de semana"],
            "tendencias_gastos": "Gastos estables"
        }